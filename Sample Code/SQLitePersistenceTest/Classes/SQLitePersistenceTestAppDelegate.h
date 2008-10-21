//
//  SQLitePersistenceTestAppDelegate.h
//  SQLitePersistenceTest
//
//  Created by Jeff LaMarche on 10/20/08.
//  Copyright Jeff LaMarche Consulting 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQLitePersistenceTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *rootViewController;
@end

