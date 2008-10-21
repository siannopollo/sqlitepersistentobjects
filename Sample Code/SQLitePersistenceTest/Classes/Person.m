//
//  Person.m
//  SQLitePersistenceTest
//
//  Created by Jeff LaMarche on 10/20/08.
//  Copyright 2008 Jeff LaMarche Consulting. All rights reserved.
//

#import "Person.h"


@implementation Person
@synthesize name;
@synthesize birthDate;
@synthesize image;
@synthesize favoriteInt;

- (void)dealloc
{
	[name release];
	[birthDate release];
	[image release];
	[super dealloc];
}

@end
