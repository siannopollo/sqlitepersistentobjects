//
//  BasicData.h
//  SQLiteTests
//
//  Created by al on 16/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface BasicData : SQLitePersistentObject
{		
	int					_b1;
	unsigned int		_b2;
	long				_b3;
	unsigned long		_b4;
	long long			_b5;
	unsigned long long	_b6;
	short				_b7;
	unsigned short		_b8;
	BOOL				_b9;
	float				_b10;
	double				_b11;
}

@property int b1;
@property unsigned int b2;
@property long b3;
@property unsigned long b4;
@property long long b5;
@property unsigned long long b6;
@property short b7;
@property unsigned short b8;
@property BOOL b9;
@property float b10;
@property double b11;

-(void) setFixtureData;
@end
