//
//  AddBookViewController.m
//  BookReading
//
//  Created by Thabib on 07/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "AddBookViewController.h"
#import "CoreDataFactory.h"
#import "StatustableViewController.h"
@interface AddBookViewController ()

@end

@implementation AddBookViewController
@synthesize dateActionSheet,datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundAdd.png"]]];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    //UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundAdd.png"]];
//
//    [self.view addSubview:backgroundImage];
//    [self.view sendSubviewToBack:backgroundImage];
    
    
    [super viewDidLoad];
    self.addbooktitle.font=[UIFont fontWithName:@"Steiner" size:40];
    self.addauthortitle.font=[UIFont fontWithName:@"Steiner" size:30];
    self.addtotnopages.font=[UIFont fontWithName:@"Steiner" size:40];
    
    //1
    CoreDataFactory * datamanager = [[CoreDataFactory alloc]init];
    //2
    self.managedObjectContext = datamanager.managedObjectContext;
    [super viewDidLoad];
    _booknametextfield.delegate = self;
    _authornametextfield.delegate = self;
    _totalpagestextfield.delegate = self;
   
    
    
    dateActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Start Date"
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerDateToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *cancelbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [barItems addObject:cancelbtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDoneClick:)];
    [barItems addObject:doneBtn];
    
    
    
    
    
    [pickerDateToolbar setItems:barItems animated:YES];
    
    [self.dateActionSheet addSubview:pickerDateToolbar];
    [self.dateActionSheet addSubview:self.datePicker];

    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)cancel:(id)sender{
    
    
    [self.dateActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


-(void)datePickerDoneClick:(id)sender{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *dateString = [formatter stringFromDate:self.datePicker.date];
    
    
    self.dateResultLabel.text = dateString;
    [self.dateActionSheet dismissWithClickedButtonIndex:1 animated:YES];
}


-(NSDate *)getDateFromString:(NSString *)pstrDate
{
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"dd-MM-yyyy"];
    NSDate *dtPostDate = [df1 dateFromString:pstrDate];
    NSLog(@"%@",dtPostDate);
    return dtPostDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectStartDate:(id)sender {
    
    [self.dateActionSheet showInView:self.view];
    [self.dateActionSheet setBounds:CGRectMake(0,0,320, 464)];

}

- (IBAction)AddbookToDatabase:(id)sender {
    if (![self.booknametextfield.text isEqualToString:@""] && ![self.authornametextfield.text isEqualToString:@""] && ![self.totalpagestextfield.text isEqualToString:@""] && ![self.dateResultLabel.text isEqualToString:@""])
    {
        //  1
        Book * newEntry =[NSEntityDescription insertNewObjectForEntityForName:@"Book"
                                   inManagedObjectContext:self.managedObjectContext];
         //  2
        newEntry.bookName = self.booknametextfield.text;
         newEntry.authorName = self.authornametextfield.text;
        
         NSString *str = self.totalpagestextfield.text;
        int x = [str intValue];
         newEntry.totalPages = [NSNumber numberWithInt:x];
        
        newEntry.startDate = [self getDateFromString:self.dateResultLabel.text];
        
         //  3
         NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
           }
        //  4
        self.booknametextfield.text = @"";
         self.authornametextfield.text = @"";
        self.totalpagestextfield.text = @"";
        
        self.dateResultLabel.text = @"";
        //  5
        [self add];
         [self.view endEditing:YES];
       }
    else
     {
            NSString *t1=self.booknametextfield.text;
             NSString *t2=self.authornametextfield.text;
            NSString *t3=self.totalpagestextfield.text;
             if(([t1 length]<=0) || ([t2 length]<=0) || ([t3 length]<=0))
                 {
                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error"message:@"Fill all Textfields" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
                    [self.view endEditing:YES];
                    [alert show];
                    
                    }
            }
    
    
}
-(void)add
{
     [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationIdentifier"] animated:YES completion:nil];
}

//    if (![self.booknametextfield.text isEqualToString:@""] && ![self.authornametextfield.text isEqualToString:@""] && ![self.totalpagestextfield.text isEqualToString:@""] && ![self.dateResultLabel.text isEqualToString:@""])
//    {
//        //  1
//        Book * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Book"
//                                                               inManagedObjectContext:self.managedObjectContext];
//        //  2
//        newEntry.bookName = self.booknametextfield.text;
//        newEntry.authorName = self.authornametextfield.text;
//        
//        NSString *str = self.totalpagestextfield.text;
//        int x = [str intValue];
//        newEntry.totalPages = [NSNumber numberWithInt:x];
//        
//        newEntry.startDate = [self getDateFromString:self.dateResultLabel.text];
//        
//        //  3
//        NSError *error;
//        if (![self.managedObjectContext save:&error]) {
//            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//        }
//        //  4
//        self.booknametextfield.text = @"";
//        self.authornametextfield.text = @"";
//        self.totalpagestextfield.text = @"";
//        
//        self.dateResultLabel.text = @"";
//        //  5
//        [self.view endEditing:YES];
//    }
//
//}
//- (IBAction)Backtohome:(id)sender
//
//{
//    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationIdentifier"] animated:YES completion:nil];
//   // [self presentModalViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"] animated:NO];
//}
- (IBAction)pushtohome1:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationIdentifier"] animated:YES completion:nil];
   // [self presentModalViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"] animated:NO];
}

- (IBAction)pushtomenu:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:YES completion:nil];
    //[self presentModalViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:NO];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
@end
