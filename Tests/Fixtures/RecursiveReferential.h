//
//  RecursiveReferential.h
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface RecursiveReferential : SQLitePersistentObject
{		
	RecursiveReferential*	_ref;
}

@property(assign) RecursiveReferential* ref;
@end
