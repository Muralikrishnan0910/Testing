//
//  AddBookViewController.h
//  BookReading
//
//  Created by Thabib on 07/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface AddBookViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addtotnopages;
@property (weak, nonatomic) IBOutlet UITextField *addauthortitle;
@property (weak, nonatomic) IBOutlet UITextField *addbooktitle;
@property (weak, nonatomic) IBOutlet UITextField *booknametextfield;
@property (weak, nonatomic) IBOutlet UITextField *authornametextfield;
@property (weak, nonatomic) IBOutlet UITextField *totalpagestextfield;
@property (weak, nonatomic) IBOutlet UILabel *dateResultLabel;
@property (nonatomic, strong) UIActionSheet *dateActionSheet;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
- (IBAction)selectStartDate:(id)sender;
- (IBAction)AddbookToDatabase:(id)sender;

@end
