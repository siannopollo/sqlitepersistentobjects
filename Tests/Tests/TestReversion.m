//
//  TestReversion.m
//  SQLiteTests
//
//  Created by Scott Lyons on 27/02/09.
//
#import "GTMSenTestCase.h"
#import "SQLitePersistentObject.h"
#import "SQLiteInstanceManager.h"
#import "NSString-SQLiteColumnName.h"
#import "Collections.h"
#import "NSDataContainer.h"
#import "RecursiveReferential.h"

@interface TestReversion : SenTestCase 
{
   SQLiteInstanceManager* _manager;
}
@end


@implementation TestReversion

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


- (void)testFullReversion
{
   BasicData *bd = [[BasicData alloc] init];
   [bd setFixtureData];
   [bd save];
   
   int old = bd.b1;
   bd.b1 = 9;
   [bd revert];
   STAssertTrue(bd.b1 == old, @"Revert method");
   
   Collections* col = [[Collections alloc] init];
   [col setFixtureData];
   [col save];
   
   [col.stringsArray release];
   col.stringsArray = nil;
   [col revert];
   STAssertTrue(col.stringsArray != nil, @"Collections in revert method");
}

- (void)testFieldReversion
{
   BasicData *bd = [[BasicData alloc] init];
   [bd setFixtureData];
   [bd save];
   
   int old = bd.b2;
   bd.b2 = 42;
   [bd revertProperty:@"b2"];
   STAssertTrue(bd.b2 == old, @"Revert field method");
}

@end