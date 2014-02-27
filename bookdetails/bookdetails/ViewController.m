//
//  ViewController.m
//  bookdetails
//
//  Created by BSA Univ15 on 13/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import "ViewController.h"
#import "BookDetails.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *booknameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *authornameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *totalpageTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pagesreadTextfield;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)addbookButton:(id)sender;
- (IBAction)showbookButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //1
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //2
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addbookButton:(id)sender
{
    BookDetails *newentry=[NSEntityDescription insertNewObjectForEntityForName:@"BookDetails" inManagedObjectContext:self.managedObjectContext];
    
    newentry.bookname=self.booknameTextfield.text;
    newentry.authorname=self.authornameTextfield.text;
    newentry.totalpages=self.totalpageTextfield.text;
    newentry.pagesread=self.pagesreadTextfield.text;
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Couldn't Save:%@",[error localizedDescription]);
    }
    
    self.booknameTextfield.text=@"";
    self.authornameTextfield.text=@"";
    self.totalpageTextfield.text=@"";
    self.pagesreadTextfield.text=@"";
    [self.view endEditing:YES];
    
}

- (IBAction)showbookButton:(id)sender {
}
@end
