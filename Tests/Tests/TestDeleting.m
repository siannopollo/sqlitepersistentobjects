#import "GTMSenTestCase.h"
#import "SQLitePersistentObject.h"
#import "SQLiteInstanceManager.h"
#import "NSString-SQLiteColumnName.h"
#import "Collections.h"
#import "NSDataContainer.h"
#import "RecursiveReferential.h"

@interface TestDeleting : SenTestCase 
{
	SQLiteInstanceManager* _manager;
}

@end

@implementation TestDeleting

-(id) init
{
	_manager = [SQLiteInstanceManager sharedManager];
	[_manager deleteDatabase];
	return self;
}

-(BOOL) sqliteStatementReturnsData:(NSString*)sql
{
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2( [_manager database], [sql UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{
		if (sqlite3_step(statement) == SQLITE_ROW)
		{
			return TRUE;
		}
	}
	return FALSE;
}

extern NSMutableArray* recursionCheck;

-(BOOL) areThereAnyTracesOfObject:(SQLitePersistentObject*)object cascade:(BOOL)cascade
{
	if( [self sqliteStatementReturnsData:[NSString stringWithFormat:@"SELECT * FROM %@ where PK = %d", [[object class] tableName], [object pk]]])
		return TRUE;
	
	NSDictionary *theProps = [[object class] propertiesWithEncodedTypes];
	for (NSString *prop in [theProps allKeys])
	{
		NSString *colType = [theProps valueForKey:prop];
		if (cascade && [colType hasPrefix:@"@"])
		{
			NSString *className = [colType substringWithRange:NSMakeRange(2, [colType length]-3)];
			if (isCollectionType(className))
			{
				if([self sqliteStatementReturnsData:
						[NSString stringWithFormat:@"SELECT * FROM %@_%@ WHERE parent_pk = %d",  
													[[object class] tableName], 
													[prop stringAsSQLColumnName], 
													[object pk]]
					
					])
					return TRUE;
			}	
			
			if(recursionCheck == nil )
				recursionCheck = [[NSMutableArray alloc] init];
			
			
			Class propClass = objc_lookUpClass([className UTF8String]);
			if ([propClass isSubclassOfClass:[SQLitePersistentObject class]])
			{
				SQLitePersistentObject* childObject = [object valueForKey: prop];
				if(![recursionCheck containsObject:childObject])
				{
					[recursionCheck addObject:childObject];
					if([self areThereAnyTracesOfObject:childObject cascade:cascade])
					{
						[recursionCheck removeObject:childObject];
						return TRUE;
					}
					[recursionCheck removeObject:childObject];
				}
				
			}
		}
	}
	
	return FALSE;
}

- (void)setUp
{
	NSLog(@"Database located at: %@", _manager.databaseFilepath);
}


- (void)tearDown 
{
	[_manager deleteDatabase];
}

-(void)deleteObjectWithClass:(Class)class
{
	id	obj = [[class alloc] init];
	
	[obj setFixtureData];
	[obj save];
	[obj deleteObject];
	
	STAssertFalse([self areThereAnyTracesOfObject:obj cascade:FALSE],@"");
}

-(void)deleteObjectCascadeWithClass:(Class)class
{
	id	obj = [[class alloc] init];
	
	[obj setFixtureData];
	[obj save];
	[obj deleteObjectCascade:TRUE];
	
	STAssertFalse([self areThereAnyTracesOfObject:obj cascade:TRUE],@"%@",class);
}

- (void)testShouldDeleteObjectCascade
{
	[self deleteObjectCascadeWithClass:[Collections class]];
}

- (void)testShouldIgnoreDeleteWhenObjectNotSaved
{
	BasicData* basicdData = [[BasicData alloc] init];
	STAssertNoThrow( [basicdData deleteObject], @"");
}

- (void)testShouldDeleteObject
{
	[self deleteObjectWithClass:[Collections class]];
	[self deleteObjectWithClass:[NSDataContainer class]];
	[self deleteObjectWithClass:[RecursiveReferential class]];
}

- (void)testShouldDeleteObjectAndCascade
{
	[self deleteObjectCascadeWithClass:[Collections class]];
	[self deleteObjectCascadeWithClass:[NSDataContainer class]];
	[self deleteObjectCascadeWithClass:[RecursiveReferential class]];
}

@end