//
//  Person.h
//  SQLitePersistenceTest
//
//  Created by Jeff LaMarche on 10/20/08.
//  Copyright 2008 Jeff LaMarche Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLitePersistentObject.h"

@interface Person : SQLitePersistentObject  {
	NSString	*name;
	NSDate		*birthDate;
	UIImage		*image;
	NSInteger	favoriteInt;
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *birthDate;
@property (nonatomic, retain) UIImage *image;
@property NSInteger favoriteInt;
@end
