//
//  Collections.h
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"
//#import "SQLiteMutableArray.h"

@interface Collections : SQLitePersistentObject
{		
	NSMutableArray*			stringsArray;
	NSMutableDictionary*	stringsDict;
	NSMutableSet*			stringsSet;
	
	NSMutableArray*			dataArray;
	NSMutableDictionary*	dataDict;
	NSMutableSet*			dataSet;	
}

@property(assign) NSMutableArray* stringsArray;
@property(assign) NSMutableDictionary* stringsDict;
@property(assign) NSMutableSet* stringsSet;

@property(assign) NSMutableArray* dataArray;
@property(assign) NSMutableDictionary* dataDict;
@property(assign) NSMutableSet* dataSet;

-(void) setFixtureData;

@end