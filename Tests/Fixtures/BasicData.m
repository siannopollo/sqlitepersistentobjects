//
//  BasicData.m
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BasicData.h"

@implementation BasicData
@synthesize b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11;

-(id) init
{
	[super init];
	return self;
}

-(void) setFixtureData
{
	self.b1 = 1; 
	self.b2 = 2; 
	self.b3 = 3; 
	self.b4 = 4; 
	self.b5 = 5; 
	self.b6 = 6; 
	self.b7 = 7; 
	self.b8 = 8;
	self.b9 = TRUE; 
	self.b10 = 1234.5678; 
	self.b11 = 99999999.9999999;
}

-(BOOL) isEqual:(id)obj
{
	return [[obj class] isSubclassOfClass:[self class]] && [self areAllPropertiesEqual:obj];
}

@end