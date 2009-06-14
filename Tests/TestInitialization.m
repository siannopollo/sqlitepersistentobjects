#import "GTMSenTestCase.h"
#import "SQLitePersistentObject.h"
#import "NSString-SQLiteColumnName.h"
#import "SQLitePersistentObject-Testing.h"
#import "SQLiteInstanceManager.h"
#import "NSDataContainer.h"

@interface TestInitialization : SenTestCase 
{
	SQLiteInstanceManager* _manager;
}

@end


@implementation TestInitialization

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

-(void)testShouldInitializeObjectsWithPropertyAssignment {
  NSDataContainer *container;
  BasicData *basicData = [[BasicData alloc] init];
  container = [NSDataContainer objectWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [NSNumber numberWithInteger:100], @"number",
                                                   [NSNumber numberWithInteger:200], @"transientNumber",
                                                   basicData, @"basic",
                                                   nil]];
  
  STAssertTrue([container.number integerValue] == 100, @"Container should be initialized with number of 100 but was %@", container.number);
  STAssertTrue([container.transientNumber integerValue] == 200, @"Container should be initialized with transientNumber of 200 but was %@", container.transientNumber);
  STAssertTrue(container.basic == basicData, @"Container should be initialized with basic of %@ but was %@", basicData, container.basic);
}


@end
