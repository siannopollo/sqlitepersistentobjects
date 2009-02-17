//
//  NestedCollections.m
//  SQLiteTests
//
//  Created by al on 17/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NestedCollections.h"


@implementation NestedCollections

@synthesize array=_array,set=_set,dict=_dict;

-(id) init
{
	[super init];
	_array = [[NSMutableArray alloc] init];
	_dict = [[NSMutableDictionary alloc] init];
	_set = [[NSMutableSet alloc] init];
	return self;
}

-(void) add100RandomStringsToArray:(NSMutableArray*)array
{
	char buffer[128];
	
	for (int i=0; i<100; i++) 
	{
		sprintf(buffer, "%d", (rand() % 9999) );
		NSString* string = [NSString stringWithUTF8String:buffer];
		[array addObject:string];
	}
}

-(void) setFixtureData
{
	char buffer[128];
	
	for (int i=0; i<100; i++) 
	{
		sprintf(buffer, "%d", (rand() % 9999) );
		NSString* string = [NSString stringWithUTF8String:buffer];
		
		NSMutableArray* nestedcollection = [[NSMutableArray alloc] init];
		[self add100RandomStringsToArray:nestedcollection];
		
		[self.array addObject:nestedcollection];
		[self.dict setObject:[nestedcollection copy] forKey:string];
		[self.set addObject:[nestedcollection copy]];
	}
}

@end
