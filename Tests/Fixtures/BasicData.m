//
//  BasicData.m
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BasicData.h"

@implementation BasicData
@synthesize b1=_b1,b2=_b2,b3=_b3,b4=_b4,b5=_b5,b6=_b6,b7=_b7,b8=_b8,b9=_b9,b10=_b10,b11=_b11;

-(id) init
{
	[super init];
	return self;
}

-(void) setFixtureData
{
	_b1 = 1 ; _b2 = 2 ; _b3 = 3 ; _b4 = 4 ; _b5 = 5 ; _b6 = 6 ; _b7 = 7 ; _b8 = 8 ;
	_b9 = TRUE ; _b10 = 1234.5678 ; _b11 = 99999999.9999999 ;
}

@end