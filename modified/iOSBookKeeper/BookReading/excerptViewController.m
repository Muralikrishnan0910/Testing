//
//  excerptViewController.m
//  BookReading
//
//  Created by BSA Univ15 on 26/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "excerptViewController.h"
#import "statusViewController.h"
#import "menuViewController.h"
#import "ViewController.h"
#import "CustomBookCell.h"
#import "CoredataManager.h"
#import "Book.h"
#import "UpdatePage.h"
#import "viewexcerptViewController.h"

@interface excerptViewController ()
@property(nonatomic,strong)CoredataManager *CDMobj;
@property(nonatomic,strong)UpdatePage *UpdatePageobj;
@property(nonatomic,strong)viewexcerptViewController *viewobj;
@property(nonatomic,strong)NSManagedObjectContext *managedobjectcontext;

@property(nonatomic,strong)Book *bookobj;
@property(nonatomic,strong)NSArray *bookData;

@property(nonatomic,strong)NSString *strcpy2;
@property(nonatomic,strong)NSNumber *totpge;
@property(nonatomic,strong)NSNumber *pgecmp;
@end

@implementation excerptViewController


@synthesize CDMobj,bookData,UpdatePageobj,viewobj;

@synthesize totpge,pgecmp;
@synthesize pickview,segcontrol,completedLabel;
- (IBAction)pushtomenu:(id)sender
{
   [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:YES completion:nil];
}
- (IBAction)pushtohome:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationIdentifier"] animated:YES completion:nil];
}

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
    CDMobj = [[CoredataManager alloc]init];
    bookData = [CDMobj getAllBookRecords];
    UpdatePageobj = [[UpdatePage alloc]init];
    
    //viewobj=[[viewexcerptViewController alloc]init];
    self.managedobjectcontext = CDMobj.managedObjectContext;
    
        [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return bookData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *CellIdentifier1= @"Cell1";
    
    CustomBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    CustomBookCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell==nil) {
        cell = [[CustomBookCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if (cell1==nil) {
       cell1 = [[CustomBookCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1];
    }
         self.bookobj =  [bookData objectAtIndex:indexPath.row];
    
    totpge=self.bookobj.totalPages;
    pgecmp=self.bookobj.pagesCompleted;
  
    if ([totpge isEqualToNumber:pgecmp])
    {
        cell.bookNameLabel.text=self.bookobj.bookName;
        for(int i=0;i<[bookData count];i++)
        {
        if (indexPath.row == i)
        {
        self.strcpy2=cell.bookNameLabel.text;
        }
        }
        NSLog(@"123456%@",viewobj.strcpy);
        cell.authorNameLabel.text=self.bookobj.authorName;
        return cell;
    }
    else
    {
        cell1.bookNameTableLabel.text=self.bookobj.bookName;
        cell1.authorNameTableLabel.text=self.bookobj.authorName;
        return cell1;
        
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
viewexcerptViewController *view =[self.storyboard instantiateViewControllerWithIdentifier:@"viewexcerptViewController"];
    
   view.selectedbook=[self.bookData objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:view animated:YES];
    
    
    
}
- (IBAction)viewnotes:(id)sender
{
    viewobj=[self.storyboard instantiateViewControllerWithIdentifier:@"viewexcerptViewController"];
    viewobj.strcpy=self.strcpy2;
    [self presentViewController:viewobj animated:YES completion:nil];
}
-(IBAction)segmentUpdate:(id)sender
{
    if (segcontrol.selectedSegmentIndex==0)
    {
        self.completedLabel.text=@"Completed";
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        pickview.frame=CGRectMake(0,600,320,252);
        [UIView commitAnimations];
        
    }
    else if(segcontrol.selectedSegmentIndex==1)
    {
        self.completedLabel.text=@"Reading";
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        pickview.frame=CGRectMake(0,228,320,252);
        [UIView commitAnimations];
    }
    else{
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender
{
  [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:YES completion:nil];
}
@end
