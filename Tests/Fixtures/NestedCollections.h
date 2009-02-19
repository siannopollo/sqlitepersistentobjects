//
//  Collections.h
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface NestedCollections : SQLitePersistentObject
{		
	NSMutableArray*			array;
	NSMutableDictionary*	dict;
	NSMutableSet*			set;
}

@property(assign) NSMutableArray* array;
@property(assign) NSMutableDictionary* dict;
@property(assign) NSMutableSet* set;

@end