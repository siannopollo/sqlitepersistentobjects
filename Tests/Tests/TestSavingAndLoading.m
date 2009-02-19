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
	[col.array release];
	col.array = nil;
	
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

-(void)saveAndLoadWhenObjectContainsDataWithClass:(Class)class
{
	id	memory = [[class alloc] init];
	id	database;
	
	[memory setFixtureData];
	[memory save];
	[SQLitePersistentObject clearCache];
	database = [class findByPK:[memory pk]];
	
	STAssertTrue([memory areAllPropertiesEqual:database], @"%@", [memory description]);
}

- (void)testShouldSaveAndLoadWhenObjectContainsData
{
	[self saveAndLoadWhenObjectContainsDataWithClass: [BasicData class]];
	[self saveAndLoadWhenObjectContainsDataWithClass: [NSDataContainer class]];
	[self saveAndLoadWhenObjectContainsDataWithClass: [Collections class]];
	
	//UNSUPPORTED OPERATIONS
	//[self saveAndLoadWhenObjectContainsDataWithClass: [NestedCollections class]];
	//[self saveAndLoadWhenObjectContainsDataWithClass: [RecursiveReferential class]];
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
	[self shouldMakeDirtyAndSaveAllModifiedPropertiesWhenObjectHasBeenModifiedAfterSavingWithClass: [Collections class]];
	
	//UNSUPPORTED OPERATIONS
	//[self saveAndLoadWhenObjectContainsDataWithClass: [NestedCollections class]];
	//[self saveAndLoadWhenObjectContainsDataWithClass: [RecursiveReferential class]];
}



@end