//
//  UpdatePage.m
//  BookReading
//
//  Created by Thabib on 24/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "UpdatePage.h"
#import "AppDelegate.h"
#import "CoredataManager.h"
#import "saveandpubViewController.h"
#import "ViewController.h"
#import "GRAlertView.h"
@interface UpdatePage ()
{
    NSNumber *ttlpages;
    NSManagedObjectContext *context;
   
}

- (IBAction)backButton:(id)sender;

@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;

@property(nonatomic,strong)CoredataManager *CDMobj;

@property(nonatomic,strong)NSNumber *tlpge;
@property(nonatomic,strong)NSNumber *pgcmp;
@end

@implementation UpdatePage
@synthesize CDMobj,tlpge,pgcmp;

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
     self.updatebooktitle.font=[UIFont fontWithName:@"Steiner" size:35];
     self.updateauthortitle.font=[UIFont fontWithName:@"Steiner" size:35];
     self.updatetotalpages.font=[UIFont fontWithName:@"Steiner" size:35];
     self.updatereadtoday.font=[UIFont fontWithName:@"Steiner" size:30];
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    self.managedObjectContext=appDelegate.managedObjectContext;
    
    self.PagesCompletedField.delegate = self;
   
    [self initialSetup];
//    CDMobj = [[CoredataManager alloc]init];
//    self.managedobjectcontext = CDMobj.managedObjectContext;
//    self.PagesCompletedField.delegate = self;

   
	// Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initialSetup
{
    self.BooknameLabel.text=self.selectedbook.bookName;
    self.AuthorNameLabel.text=self.selectedbook.authorName;
    
    ttlpages=self.selectedbook.totalPages;
    NSString *totalpgs=[NSString stringWithFormat:@"%@",ttlpages];
    self.TotalPagesLabel.text=totalpgs;
    
    NSLog(@"%@",totalpgs);
    
    NSString *pagscmpltd=[NSString stringWithFormat:@"%@",self.selectedbook.pagesCompleted];
    self.PagesCompletedField.text=pagscmpltd;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:self.editButtonItem.style                                                             target:self action:@selector(doneButtonPressed)];
}

- (void)doneButtonPressed
{
    
    NSString *pagcmplt=self.PagesCompletedField.text;
    NSNumber *pagecmpltd=[NSNumber numberWithInt:[pagcmplt intValue]];
    if ([ttlpages doubleValue] < [pagecmpltd doubleValue])
    {
        NSLog(@"done");
        ////// Info
        GRAlertView *alert= [[GRAlertView alloc] initWithTitle:@"Info"
                                                       message:@"You Are Exceeded Your Page Limit"
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:nil];
        alert.style = GRAlertStyleInfo;
        [alert setImage:@"info.png"];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(closeAlert:) userInfo:alert repeats:NO];
        [alert show];
        self.PagesCompletedField.text=@"";
    }
    else{
    tlpge=self.selectedbook.totalPages;
    pgcmp=self.selectedbook.pagesCompleted;
    self.selectedbook.pagesCompleted=pagecmpltd;
    if ([ttlpages doubleValue] == [pagecmpltd doubleValue])
    {
        self.selectedbook.bookStatus=@"Yes";
        
    }
    
    else
    {
        
        self.selectedbook.bookStatus=@"No";
    }
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationIdentifier"] animated:YES completion:nil];
    }
}
- (IBAction)btn_AddNotes:(id)sender {
    NSLog(@"Check");
    saveandpubViewController *save=[self.storyboard instantiateViewControllerWithIdentifier:@"saveandpubViewController"];
    save.str=self.BooknameLabel.text;
    save.str1=self.AuthorNameLabel.text;
    [self presentViewController:save animated:YES completion:nil];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.PagesCompletedField resignFirstResponder];
    return YES;
}
- (void)closeAlert:(NSTimer*)timer {
    [(UIAlertView*) timer.userInfo  dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)backButton:(id)sender
{
[self dismissViewControllerAnimated:YES completion:Nil];
}
- (IBAction)pushtoaddexcerpts:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"saveandpubViewController"] animated:YES completion:nil];
 
    
   
}
@end
