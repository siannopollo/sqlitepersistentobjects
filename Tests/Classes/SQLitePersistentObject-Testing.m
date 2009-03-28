//
//  SQLitePersistentObject-Testing.m
//  SQLiteTests
//
//  Created by al on 28/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SQLitePersistentObject-Testing.h"


@implementation SQLitePersistentObject(Testing)

NSMutableArray* recursionCheck;

-(BOOL) areAllPropertiesEqual:(SQLitePersistentObject*)object
{
	NSDictionary *theProps = [[self class] propertiesWithEncodedTypes];
	BOOL returnValue = YES;
	
	if( ![[object class] isSubclassOfClass:[self class]] )
		return NO;
	
	if(recursionCheck == nil )
		recursionCheck = [[NSMutableArray alloc] init];
	
	[recursionCheck addObject:self];
	
	for (NSString *prop in [theProps allKeys])
	{
		id myProperty = [self valueForKey:prop];
		id theirProperty = [object valueForKey:prop];
		
		if(myProperty == nil || theirProperty == nil)
			continue;
		
		if(![myProperty isEqual:theirProperty])
		{
			//if the numbers are both floats, allow some margin of error
			if( [[myProperty class] isSubclassOfClass: [NSNumber class]] )
			{
				float mine = [myProperty floatValue];
				float theirs = [theirProperty floatValue];
				if(fabs(mine-theirs) < 0.001)
					continue;
			}
			
			if( [[myProperty class] isSubclassOfClass: [NSDate class]] &&
			   fabs([myProperty timeIntervalSinceDate: theirProperty]) < 0.001
			   )
				continue;
			
			//			NSMutableString *desc = [[NSMutableString alloc]initWithCapacity:9999];
			//			[desc appendString:@"\nProperty was not equal:"];
			//			[desc appendString:prop];
			//			[desc appendString:@" = "];
			//			[desc appendString:[myProperty description]];
			//			[desc appendString:@" was not equal to "];
			//			[desc appendString:[theirProperty description]];
			//			NSLog(desc);
			returnValue = NO;
		}
		
		if(	[[myProperty class] isSubclassOfClass:[SQLitePersistentObject class]] &&
		   [[theirProperty class] isSubclassOfClass:[SQLitePersistentObject class]] &&
		   ![recursionCheck containsObject:theirProperty] &&
		   ![recursionCheck containsObject:myProperty] )
		{
			if( ![myProperty areAllPropertiesEqual:theirProperty] )
			{
				[recursionCheck removeObject:self];
				return NO;
			}
		}
	}
	
	[recursionCheck removeObject:self];
	return returnValue;
}


@end
