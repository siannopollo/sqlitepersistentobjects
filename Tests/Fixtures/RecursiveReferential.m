//
//  RecursiveReferential.m
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RecursiveReferential.h"


@implementation RecursiveReferential

@synthesize ref;

-(id) init
{
	[super init];
	return self;
}

-(void) setFixtureData
{
	self.ref = [[RecursiveReferential alloc] init];
	self.ref.ref = self;
}

- (BOOL)isEqual:(id)object
{
	return [object class] == [self class] && [(RecursiveReferential*)object pk] == self.pk;
}

@end