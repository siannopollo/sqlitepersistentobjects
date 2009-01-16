//
//  NSDataContainer.h
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface NSDataContainer : SQLitePersistentObject
{		
	unsigned	unsignedArray[100];
	NSData*		_unsignedArrayData;
	
	CGRect		rect;
	NSData*		_rectData;
}

@property(assign) NSData* unsignedArrayData;
@property(assign) NSData* rectData;

@end
