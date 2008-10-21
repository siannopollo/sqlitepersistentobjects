//
//  PersonDetailController.m
//  SQLitePersistenceTest
//
//  Created by Jeff LaMarche on 10/20/08.
//  Copyright 2008 Jeff LaMarche Consulting. All rights reserved.
//

#import "PersonDetailController.h"
#import "Person.h"
#import "SQLitePersistenceTestAppDelegate.h"
#import "MainListController.h"
@implementation PersonDetailController
@synthesize nameField;
@synthesize favoriteNumberField;
@synthesize imageView;
@synthesize datePicker;
@synthesize person;
- (IBAction)finishedEditingText:(id)sender
{
	[sender resignFirstResponder];
}
- (IBAction)backgroundClick
{
	[nameField resignFirstResponder];
	[favoriteNumberField resignFirstResponder];
}

- (IBAction)takePicture
{
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
		picker.delegate = self;
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
		picker.allowsImageEditing = YES;
		[self presentModalViewController:picker animated:YES];
		[picker release];
	}
}
- (IBAction)save:(id)sender
{
	person.name = nameField.text;
	person.favoriteInt = [favoriteNumberField.text intValue];
	person.birthDate = datePicker.date;
	[person save];
	
	SQLitePersistenceTestAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	UINavigationController *navController = [delegate rootViewController];
	MainListController *mainListController = [navController.viewControllers objectAtIndex:0];
	[mainListController refreshList];
	[mainListController.tableView reloadData];
	
	[navController popViewControllerAnimated:YES];

}
- (void)viewDidLoad
{
	if (person.name)
		nameField.text = person.name;
	
	favoriteNumberField.text = [NSString stringWithFormat:@"%d", person.favoriteInt];
	
	if (person.image)
		imageView.image = person.image;
	
	if (person.birthDate)
		datePicker.date = person.birthDate;
	else
		datePicker.date = [NSDate date];
	
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"Save"
								   style:UIBarButtonItemStylePlain
								   target:self
								   action:@selector(save:)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[nameField release];
	[favoriteNumberField release];
	[imageView release];
	[datePicker release];
	[person release];
    [super dealloc];
}

#pragma mark  -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
	imageView.image = image;
	person.image = image;
	[picker dismissModalViewControllerAnimated:YES];
	
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	
	[picker dismissModalViewControllerAnimated:YES];
}
@end
