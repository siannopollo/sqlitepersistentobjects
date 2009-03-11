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
	int					b1;
	unsigned int		b2;
	long				b3;
	unsigned long		b4;
	long long			b5;
	unsigned long long	b6;
	short				b7;
	unsigned short		b8;
	BOOL				b9;
	float				b10;
	double				b11;
	double				b12;
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
