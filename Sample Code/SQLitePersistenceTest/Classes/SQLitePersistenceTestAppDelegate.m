//
//  SQLitePersistenceTestAppDelegate.m
//  SQLitePersistenceTest
//
//  Created by Jeff LaMarche on 10/20/08.
//  Copyright Jeff LaMarche Consulting 2008. All rights reserved.
//

#import "SQLitePersistenceTestAppDelegate.h"
#import "MainListController.h"
@implementation SQLitePersistenceTestAppDelegate

@synthesize window;
@synthesize rootViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	[window addSubview:rootViewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
