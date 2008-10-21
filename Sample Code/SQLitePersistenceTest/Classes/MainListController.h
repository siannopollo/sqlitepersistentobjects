//
//  MainListController.h
//  SQLitePersistenceTest
//
//  Created by Jeff LaMarche on 10/20/08.
//  Copyright 2008 Jeff LaMarche Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainListController : UITableViewController {

	NSMutableArray *names;
	NSMutableDictionary *keyLookup;
	
}
@property (nonatomic, retain) NSMutableArray *names;
@property (nonatomic, retain) NSMutableDictionary *keyLookup;
-(IBAction)newPerson:(id)sender;
-(void)refreshList;
@end
