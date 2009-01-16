//
//  NSDataContainer.m
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSDataContainer.h"

@implementation NSDataContainer

-(NSData*) unsignedArrayData
{
	return [[NSData alloc] initWithBytes:unsignedArray length:sizeof(unsigned)*100];
}

-(void) setUnsignedArrayData:(NSData*)data
{
	unsigned* dataBytes = (unsigned*)[data bytes];
	for (int i=0; i<100; i++) 
	{
		unsignedArray[i] = dataBytes[i];
	}
}

-(NSData*) rectData
{
	return [[NSData alloc] initWithBytes:&rect length:sizeof(CGRect)];
}

-(void) setRectData:(NSData*)data
{
	CGRect* rectBytes = (CGRect*)[data bytes];
	rect.size.width = rectBytes->size.width;
	rect.size.height = rectBytes->size.height;
	rect.origin.x = rectBytes->origin.x;
	rect.origin.y = rectBytes->origin.y;
}

-(id) init
{
	[super init];
	return self;
}

-(void) dealloc
{
	//[_unsignedArrayData release];
	[super dealloc];
}

-(void) setFixtureData
{
	for (int i=0; i<100; i++) 
	{
		unsignedArray[i] = rand() % 9999;
	}
	rect = CGRectMake(1, 2, 3, 4);
}

@end
