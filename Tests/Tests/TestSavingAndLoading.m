#import "GTMSenTestCase.h"
#import "SQLitePersistentObject.h"
#import "SQLiteInstanceManager.h"
#import "BasicData.h"
#import "NSDataContainer.h"
#import "Collections.h"
#import "RecursiveReferential.h"

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
	
	STAssertTrue([memory areAllPropertiesEqual:database], @"");
}

- (void)testShouldSaveAndLoadWhenObjectContainsNothing
{
	[self saveAndLoadWhenObjectContainsNothingWithClass: [BasicData class]];
	[self saveAndLoadWhenObjectContainsNothingWithClass: [NSDataContainer class]];
	[self saveAndLoadWhenObjectContainsNothingWithClass: [Collections class]];
	[self saveAndLoadWhenObjectContainsNothingWithClass: [RecursiveReferential class]];
}

-(void)saveAndLoadWhenObjectContainsDataWithClass:(Class)class
{
	id	memory = [[class alloc] init];
	id	database;
	
	[memory setFixtureData];
	[memory save];
	[SQLitePersistentObject clearCache];
	database = [class findByPK:[memory pk]];
	
	STAssertTrue([memory areAllPropertiesEqual:database], @"");
}

- (void)testShouldSaveAndLoadWhenObjectContainsData
{
	[self saveAndLoadWhenObjectContainsDataWithClass: [BasicData class]];
	[self saveAndLoadWhenObjectContainsDataWithClass: [NSDataContainer class]];
	[self saveAndLoadWhenObjectContainsDataWithClass: [Collections class]];
	
	//infinite loop
	//[self saveAndLoadWhenObjectContainsDataWithClass: [RecursiveReferential class]];
}

@end