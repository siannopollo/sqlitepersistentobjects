//
//  NSDataContainer.h
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"
#import "BasicData.h"

@interface NSDataContainer : SQLitePersistentObject
{		
	unsigned	unsignedArray[100];
	NSData*		_unsignedArrayData;
	
	CGRect		rect;
	NSData*		_rectData;
	
	NSNumber*	_number;
	NSDate*		_date;
	BasicData*	_basic;
}

@property(assign) NSData* unsignedArrayData;
@property(assign) NSData* rectData;
@property(assign) NSNumber* number;
@property(assign) NSDate* date;
@property(assign) BasicData* basic;
@end
