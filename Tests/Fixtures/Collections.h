//
//  Collections.h
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface Collections : SQLitePersistentObject
{		
	NSMutableArray*			_array;
	NSMutableDictionary*	_dict;
	NSMutableSet*			_set;
}

@property(assign) NSMutableArray* array;
@property(assign) NSMutableDictionary* dict;
@property(assign) NSMutableSet* set;

@end