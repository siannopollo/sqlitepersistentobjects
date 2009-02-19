//
//  Collections.m
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Collections.h"


@implementation Collections

@synthesize array,set,dict;

-(id) init
{
	[super init];
	array = [[NSMutableArray alloc] init];
	dict = [[NSMutableDictionary alloc] init];
	set = [[NSMutableSet alloc] init];
	return self;
}

-(void) setFixtureData
{
	char buffer[128];
	
	for (int i=0; i<100; i++) 
	{
		sprintf(buffer, "%d", (rand() % 9999) );
		NSString* string = [NSString stringWithUTF8String:buffer];
		
		[self.array addObject:string];
		[self.dict setObject:string forKey:string];
		[self.set addObject:string];
	}
}

@end