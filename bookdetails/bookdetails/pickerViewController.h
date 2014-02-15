//
//  pickerViewController.h
//  bookdetails
//
//  Created by BSA Univ15 on 15/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BookDetails.h"
#import "BookRecordViewController.h"
#import "UpdatePage.h"

@interface pickerViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
// Core Data
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(weak,nonatomic)UIActionSheet *dataselectactionsheet;
@property(weak,nonatomic)UIPickerView *datapick;
@property(nonatomic,strong)BookDetails *selectedbook;

- (IBAction)booklistButton:(id)sender;
- (IBAction)doneButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *bookPicker;
@property (weak, nonatomic) IBOutlet UILabel *booknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authornameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalpagesLabel;


@property (weak, nonatomic) IBOutlet UITextField *pagereadTextfield;
@property(nonatomic,strong)NSArray *booknames;


@end
