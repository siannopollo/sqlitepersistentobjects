//
//  Collections.m
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Collections.h"


@implementation Collections

@synthesize array=_array,set=_set,dict=_dict;

-(id) init
{
	[super init];
	_array = [[NSMutableArray alloc] init];
	_dict = [[NSMutableDictionary alloc] init];
	_set = [[NSMutableSet alloc] init];
	return self;
}

-(void) setFixtureData
{
	char buffer[128];
	
	for (int i=0; i<100; i++) 
	{
		sprintf(buffer, "%d", (rand() % 9999) );
		NSString* string = [NSString stringWithUTF8String:buffer];
		
		[_array addObject:string];
		[_dict setObject:string forKey:string];
		[_set addObject:string];
	}
}

@end