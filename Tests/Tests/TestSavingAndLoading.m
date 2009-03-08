#import "GTMSenTestCase.h"
#import "SQLitePersistentObject.h"
#import "SQLiteInstanceManager.h"
#import "BasicData.h"
#import "NSDataContainer.h"
#import "Collections.h"
#import "RecursiveReferential.h"
#import "NestedCollections.h"

@interface TestSavingAndLoading : SenTestCase 
{
	SQLiteInstanceManager* _manager;
}

@end

@implementation TestSavingAndLoading

-(id) init
{
	_manager = [SQLiteInstanceManager sharedManager];
	[_manager deleteDatabase];
	return self;
}

- (void)setUp
{
	NSLog(@"Database located at: %@", _manager.databaseFilepath);
}


- (void)tearDown 
{
	[_manager deleteDatabase];
}


-(void)saveAndLoadWhenObjectContainsNothingWithClass:(Class)class
{
	id memory = [[class alloc] init];
	id database;
	
	[memory save];
	[SQLitePersistentObject clearCache];
	database = [class findByPK:[memory pk]];
	
	STAssertTrue([memory areAllPropertiesEqual:database], @"%@", class);
}

- (void)testShouldSaveAndLoadWhenPropetyIsNil
{
	Collections*	col = [[Collections alloc] init];
	Collections*	database;
	[col setFixtureData];
	[col.stringsArray release];
	col.stringsArray = nil;
	
	[col save];
	[SQLitePersistentObject clearCache];
	database = (Collections*)[Collections findByPK:[col pk]];
	
	STAssertTrue([col areAllPropertiesEqual:database], @"");
}

- (void)testShouldSaveAndLoadWhenObjectContainsNothing
{
	[self saveAndLoadWhenObjectContainsNothingWithClass: [BasicData class]];
	[self saveAndLoadWhenObjectContainsNothingWithClass: [NSDataContainer class]];
	[self saveAndLoadWhenObjectContainsNothingWithClass: [Collections class]];
	[self saveAndLoadWhenObjectContainsNothingWithClass: [RecursiveReferential class]];
	[self saveAndLoadWhenObjectContainsNothingWithClass: [NestedCollections class]];
}

- (void)saveAndLoadWhenObjectContainsDataWithClass:(Class)class
{
	id	memory = [[class alloc] init];
	id	database;
	
	[memory setFixtureData];
    STAssertFalse([memory existsInDB],@"check not in db");
	[memory save];
    STAssertTrue([memory existsInDB],@"check in db");
	[SQLitePersistentObject clearCache];
	database = [class findByPK:[memory pk]];
	
	STAssertTrue([memory areAllPropertiesEqual:database], @"%@", [memory description]);
}

- (void)assertIndex:(NSString *) expectedIndex forTable: (NSString *) tableName exists: (BOOL) indexExists
{
	sqlite3 *database = [_manager database];

	BOOL expectedIndexFound = NO;
	NSString *idxQuery = [NSString stringWithFormat:@"SELECT NAME,SQL FROM SQLITE_MASTER WHERE TBL_NAME='%@' AND TYPE='index'",
						  tableName];
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(database, [idxQuery UTF8String], -1, &statement, nil) == SQLITE_OK) 
	{
		if (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *indexName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
			if ([expectedIndex isEqualTo:indexName])
				expectedIndexFound = YES;
		}
	}			
	STAssertTrue(expectedIndexFound == indexExists, @"Failed to find expected index '%@'", expectedIndex);	
}

- (void)assertTransient:(NSString *) columnName forTable: (NSString *) tableName
{
	sqlite3 *database = [_manager database];
	
	BOOL transientConfirmed = NO;
	NSString *idxQuery = [NSString stringWithFormat:@"SELECT SQL FROM SQLITE_MASTER WHERE NAME='%@' AND TYPE='table'",
						  tableName];
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(database, [idxQuery UTF8String], -1, &statement, nil) == SQLITE_OK) 
	{
		if (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *createSql = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
			NSRange rangeOfStr = [createSql rangeOfString:[columnName stringAsSQLColumnName]];
			if (rangeOfStr.location == NSNotFound)
				transientConfirmed = YES;
		}
	}			
	STAssertTrue(transientConfirmed == YES, @"Transient property '%@' found as column '%@' on database table '%@'", columnName,[columnName stringAsSQLColumnName], tableName);	
}


- (void)testShouldSaveAndLoadWhenObjectContainsData
{
	[self saveAndLoadWhenObjectContainsDataWithClass: [BasicData class]];
	
	[self assertIndex:nil forTable:[BasicData tableName] exists:NO];
	
	[self saveAndLoadWhenObjectContainsDataWithClass: [NSDataContainer class]];

	// TODO: use one routine to derive index name here and in the main code so that changes to the naming routine do not cause a problem
	[self assertIndex:@"n_s_data_container_number" forTable:[NSDataContainer tableName] exists:YES];
	[self assertTransient:@"transientNumber" forTable:[NSDataContainer tableName]];
	
	[self saveAndLoadWhenObjectContainsDataWithClass: [Collections class]];
	[self saveAndLoadWhenObjectContainsDataWithClass: [RecursiveReferential class]];
	
	//UNSUPPORTED OPERATIONS
	//[self saveAndLoadWhenObjectContainsDataWithClass: [NestedCollections class]];
}

- (void)testShouldKeepObjectReferenceInMemoryMapWhenLoading
{
	BasicData*      basicData = [[BasicData alloc] init];
	BasicData*      basicDataDuplicate;
	int pk;
	
	[basicData setFixtureData];
	[basicData save];
	pk = [basicData pk];
	[basicData release];
	[SQLitePersistentObject clearCache];
	
	
	basicData = (BasicData*)[BasicData findByPK:pk];
	basicDataDuplicate = (BasicData*)[BasicData findByPK:pk];
	
	STAssertTrue(basicData == basicDataDuplicate, @"Objects loaded from the database twice should be exactly the same (in memory)");
}


- (void)shouldMakeDirtyAndSaveAllModifiedPropertiesWhenObjectHasBeenModifiedAfterSavingWithClass:(Class)class
{
	id	inMemoryObject = [[class alloc] init];
	id	databaseLoadedObject;
	
	[inMemoryObject save];
	[inMemoryObject setFixtureData];
	[inMemoryObject save];
	
	[SQLitePersistentObject clearCache];
	databaseLoadedObject = [class findByPK:[inMemoryObject pk]];
	
	STAssertTrue([inMemoryObject areAllPropertiesEqual:databaseLoadedObject], @"%@", [inMemoryObject description]);
}

- (void)testShouldMakeDirtyAndSaveAllModifiedPropertiesWhenObjectHasBeenModifiedAfterSaving
{
	[self shouldMakeDirtyAndSaveAllModifiedPropertiesWhenObjectHasBeenModifiedAfterSavingWithClass: [BasicData class]];
	[self shouldMakeDirtyAndSaveAllModifiedPropertiesWhenObjectHasBeenModifiedAfterSavingWithClass: [NSDataContainer class]];
	[self shouldMakeDirtyAndSaveAllModifiedPropertiesWhenObjectHasBeenModifiedAfterSavingWithClass: [RecursiveReferential class]];
	
	//UNSUPPORTED OPERATIONS
	//[self shouldMakeDirtyAndSaveAllModifiedPropertiesWhenObjectHasBeenModifiedAfterSavingWithClass: [Collections class]];
	//[self saveAndLoadWhenObjectContainsDataWithClass: [NestedCollections class]];
	//
}



@end