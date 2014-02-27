//
//  BookRecordViewController.m
//  bookdetails
//
//  Created by BSA Univ15 on 13/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import "BookRecordViewController.h"
#import "AppDelegate.h"


@interface BookRecordViewController ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation BookRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.pagesreadTextfield.delegate=self;
    [self initialSetup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initialSetup
{
    self.booknameLabel.text=self.selectedbook.bookname;
    self.authornameLabel.text=self.selectedbook.authorname;
    self.totalpagesLabel.text=self.selectedbook.totalpages;
    self.pagesreadTextfield.text=self.selectedbook.pagesread;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:self.editButtonItem.style                                                             target:self action:@selector(doneButtonPressed)];
}
- (void)doneButtonPressed
{

    self.selectedbook.pagesread=self.pagesreadTextfield.text;
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    //  3
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
    
}
@end
