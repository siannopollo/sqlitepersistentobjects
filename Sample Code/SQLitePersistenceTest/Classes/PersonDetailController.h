//
//  PersonDetailController.h
//  SQLitePersistenceTest
//
//  Created by Jeff LaMarche on 10/20/08.
//  Copyright 2008 Jeff LaMarche Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;

@interface PersonDetailController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	UITextField	*nameField;
	UITextField *favoriteNumberField;
	UIImageView *imageView;
	UIDatePicker *datePicker;
	Person *person;
}
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *favoriteNumberField;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) Person *person;
- (IBAction)finishedEditingText:(id)sender;
- (IBAction)backgroundClick;
- (IBAction)takePicture;
- (IBAction)save:(id)sender;
@end
