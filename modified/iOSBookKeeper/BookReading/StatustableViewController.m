//
//  StatustableViewController.m
//  BookReading
//
//  Created by BSA Univ15 on 28/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "StatustableViewController.h"
#import "AppDelegate.h"
#import "menuViewController.h"
#import "ViewController.h"
#import "CustomBookCell.h"
#import "CoredataManager.h"
#import "Book.h"
#import "UpdatePage.h"


@interface StatustableViewController ()


- (IBAction)backButton:(id)sender;
- (IBAction)menuButton:(id)sender;

@property(nonatomic,strong)CoredataManager *CDMobj;

@property(nonatomic,strong)NSManagedObjectContext *managedobjectcontext;

@property(nonatomic,strong)Book *bookobj;

@property (nonatomic,strong)NSArray* fetchedrecordsarray;

@property(nonatomic,strong)NSArray *bookData;

@end

@implementation StatustableViewController
@synthesize CDMobj,bookData;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.fetchedrecordsarray=[appDelegate getAllBookRecords];
    CDMobj = [[CoredataManager alloc]init];
    bookData = [CDMobj getAllBookRecords];
    self.managedobjectcontext = CDMobj.managedObjectContext;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (void)backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    //    return bookData.count;
    return [self.fetchedrecordsarray count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIImage *myImage = [UIImage imageNamed:@"current.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
    imageView.frame = CGRectMake(10,10,30,10);
    
    return imageView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   
    
    CustomBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[CustomBookCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    self.bookobj =  [bookData objectAtIndex:indexPath.row];
    
    Book *bookobje=[self.fetchedrecordsarray objectAtIndex:indexPath.row];
    [cell.bookNameLabel setFont:[UIFont boldSystemFontOfSize:20.f]];
    cell.bookNameLabel.font=[UIFont fontWithName:@"Steiner" size:20];
    
    cell.authorNameLabel.font=[UIFont fontWithName:@"Steiner" size:20];
    cell.bookNameLabel.text =[NSString stringWithFormat:@"%@",bookobje.bookName];
    cell.authorNameLabel.text = [NSString stringWithFormat:@"%@",bookobje.authorName];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM dd, yyyy"];
    NSDate *now = bookobje.startDate;
    NSString *cpydate = [format stringFromDate:now];
    cell.ssdate.text=cpydate;
    cell.pagesCompletedLabel.text=[NSString stringWithFormat:@"%@",bookobje.pagesCompleted];
    cell.slider.maximumValue=[self.bookobj.totalPages floatValue];
    cell.slider.minimumValue=0;
    
    cell.slider.value=[self.bookobj.pagesCompleted floatValue];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UpdatePage *UpdatePageobj =[self.storyboard instantiateViewControllerWithIdentifier:@"UpdatePageIdentifier"];
    
    UpdatePageobj.selectedbook=[self.fetchedrecordsarray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:UpdatePageobj animated:YES];
    
    
    
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.managedobjectcontext deleteObject:[bookData objectAtIndex:indexPath.row]];
        
        NSError *error;
        if (![self.managedobjectcontext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
    self.fetchedrecordsarray = [CDMobj getAllBookRecords];
    NSLog(@"indexpath: %@", indexPath);
    //    5
    [tableView endUpdates];
    
}
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
  return YES;
 }
- (IBAction)backButton:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"] animated:YES completion:nil];
    
}

- (IBAction)menuButton:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:YES completion:nil];

}
- (IBAction)addButton:(id)sender
{
  [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"AddBookViewController"] animated:YES completion:nil];
}
@end