//
//  RecursiveReferential.m
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RecursiveReferential.h"


@implementation RecursiveReferential

@synthesize ref=_ref;

-(id) init
{
	[super init];
	return self;
}

-(void) setFixtureData
{
	_ref = [[RecursiveReferential alloc] init];
	_ref.ref = self;
}

@end