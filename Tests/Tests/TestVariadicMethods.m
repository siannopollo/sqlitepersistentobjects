//
//  TestVariadicMethods.m
//  SQLiteTests
//
//  Created by Scott Lyons on 10/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "SQLitePersistentObject.h"
#import "SQLiteInstanceManager.h"
#import "NSString-SQLiteColumnName.h"
#import "Collections.h"
#import "NSDataContainer.h"
#import "RecursiveReferential.h"

@interface TestVariadicMethods : SenTestCase 
{
	SQLiteInstanceManager* _manager;
}
@end

@implementation TestVariadicMethods

-(id) init
{
	_manager = [SQLiteInstanceManager sharedManager];
	[_manager deleteDatabase];
	return self;
}

- (void)tearDown 
{
	[_manager deleteDatabase];
}

- (void)testVaiableArgumentMethods
{
	BasicData* bd = [[BasicData alloc] init];
	[bd setFixtureData];
	[bd save];
	
	BasicData* bd2 = (BasicData*) [BasicData findFirstByCriteria:@"WHERE b_1 = %d",1];
	STAssertTrue(bd.pk == bd2.pk, @"Variadic selection of a field");
}

@end
