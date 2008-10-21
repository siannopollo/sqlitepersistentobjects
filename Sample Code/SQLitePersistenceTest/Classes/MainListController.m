//
//  MainListController.m
//  SQLitePersistenceTest
//
//  Created by Jeff LaMarche on 10/20/08.
//  Copyright 2008 Jeff LaMarche Consulting. All rights reserved.
//

#import "MainListController.h"
#import "Person.h"
#import "PersonDetailController.h"
#import "SQLitePersistenceTestAppDelegate.h"

@implementation MainListController
@synthesize names;
@synthesize keyLookup;

-(IBAction)newPerson:(id)sender
{
	Person *person = [[Person alloc] init];
	
	PersonDetailController *detailController = [[PersonDetailController alloc] initWithNibName:@"PersonDetail" bundle:nil];
	detailController.person = person;

	
	SQLitePersistenceTestAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	UINavigationController *navController = [delegate rootViewController];
	[navController pushViewController:detailController animated:YES];
	[detailController release];
	
}
-(void)refreshList;
{
	NSMutableDictionary *dict = [Person sortedFieldValuesWithKeysForProperty:@"name"];
	self.keyLookup = dict;
	self.names = [NSMutableArray arrayWithArray:[dict allKeys]];
}
- (void)viewDidLoad {

	self.title = @"SQLite Persistence Test";
	[self refreshList];

//	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//	self.people = dict;
//	[array release];
    [super viewDidLoad];
	
	UIBarButtonItem *newButton = [[UIBarButtonItem alloc]
									 initWithTitle:@"New"
									 style:UIBarButtonItemStylePlain
									 target:self
									 action:@selector(newPerson:)];
	self.navigationItem.leftBarButtonItem = newButton;
	[newButton release];
	
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [names count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	NSUInteger row = [indexPath row];
	cell.text = [names objectAtIndex:row];
    // Configure the cell
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSUInteger row = [indexPath row];
	NSNumber *key = [keyLookup objectForKey: [names objectAtIndex:row]];
	Person *person = (Person *)[Person findByPK:[key intValue]];
	
	PersonDetailController *detailController = [[PersonDetailController alloc] initWithNibName:@"PersonDetail" bundle:nil];
	detailController.person = person;
	
	
	SQLitePersistenceTestAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	UINavigationController *navController = [delegate rootViewController];
	[navController pushViewController:detailController animated:YES];
	[detailController release];
}



- (void)dealloc {
	[names release];
	[keyLookup release];
    [super dealloc];
}


@end

