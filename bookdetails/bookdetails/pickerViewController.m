//
//  pickerViewController.m
//  bookdetails
//
//  Created by BSA Univ15 on 15/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import "pickerViewController.h"
#import "UpdatePage.h"
@interface pickerViewController ()
@property (nonatomic,strong)NSArray* fetchedrecordsarray;
@end

@implementation pickerViewController
@synthesize dataselectactionsheet,datapick;
@synthesize booknameLabel,authornameLabel,totalpagesLabel;
@synthesize pagereadTextfield;

@synthesize booknames=_booknames;
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
//    dataselectactionsheet=[[UIActionSheet alloc]initWithTitle:@"Select the Book" delegate: cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
//    _booknames=[[NSArray alloc] initWithObjects:@"Murali",@"krishnan",nil];
    if (_managedObjectContext == nil)
    {
        _managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSLog(@"After _managedObjectContext: %@",  _managedObjectContext);
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BookDetails"];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BookDetails" inManagedObjectContext:_managedObjectContext];
    request.resultType = NSDictionaryResultType;
    request.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"bookname"]];
    request.returnsDistinctResults = YES;
    
    _booknames=[_managedObjectContext executeFetchRequest:request error:nil];
    
    NSLog(@"Bookname:%@",_booknames);
    
    AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.fetchedrecordsarray=[appDelegate getAllBooks];
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.pagereadTextfield.delegate=self;
    [self initialSetup];
    
}
- (void)initialSetup
{
    //    self.booknameTextfield.text=self.selectedbook.bookname;
    //    self.authornameTextfield.text=self.selectedbook.authorname;
    //    self.totalpagesTextfield.text=self.selectedbook.totalpages;
    self.booknameLabel.text=self.selectedbook.bookname;
    self.authornameLabel.text=self.selectedbook.authorname;
    self.totalpagesLabel.text=self.selectedbook.totalpages;
    NSArray* psread=[self.selectedbook.updatepage allObjects];
    self.pagereadTextfield.text=((UpdatePage*)[psread objectAtIndex:0]).pagesread;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:self.editButtonItem.style                                                             target:self action:@selector(doneButtonPressed)];
}
- (void)doneButtonPressed
{
    //    self.selectedbook.bookname=self.booknameTextfield.text;
    //    self.selectedbook.authorname=self.authornameTextfield.text;
    //    self.selectedbook.totalpages=self.totalpagesTextfield.text;
    
    NSArray* pgnum=[self.selectedbook.updatepage allObjects];
    ((UpdatePage*)[pgnum objectAtIndex:0]).pagesread=self.pagereadTextfield.text;
    //  2
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    //  3
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)booklistButton:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:0.5];
    
    [UIView commitAnimations];
}

- (IBAction)doneButton:(id)sender
{
    NSArray* pgnum=[self.selectedbook.updatepage allObjects];
    ((UpdatePage*)[pgnum objectAtIndex:0]).pagesread=self.pagereadTextfield.text;
    //  2
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _booknames.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _booknames[row][@"bookname"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    BookDetails *bookdet=[self.fetchedrecordsarray objectAtIndex:row];
    booknameLabel.text=[NSString stringWithFormat:@"%@",bookdet.bookname];
    authornameLabel.text=[NSString stringWithFormat:@"%@",bookdet.authorname];
    totalpagesLabel.text=[NSString stringWithFormat:@"%@",bookdet.totalpages];
    
    UpdatePage *pageno1=(UpdatePage*)[[bookdet.updatepage allObjects ]objectAtIndex:0];
    pagereadTextfield.text=[NSString stringWithFormat:@"%@",pageno1.pagesread];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
    
}
@end
