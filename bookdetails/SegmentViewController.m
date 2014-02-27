//
//  SegmentViewController.m
//  bookdetails
//
//  Created by BSA Univ15 on 17/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import "SegmentViewController.h"
#import "BookDetails.h"
#import "AppDelegate.h"
#import "BookRecordViewController.h"

@interface SegmentViewController ()
@property (nonatomic,strong)NSArray* fetchedrecordsarray;

@end

@implementation SegmentViewController
@synthesize tableView;
@synthesize searchResults;


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
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.fetchedrecordsarray=[appDelegate getAllBooks];
    
//    self.searchResults = [NSArray arrayWithCapacity:[[self.fetchedrecordsarray fetchedObjects] count]];
    [self.tableView reloadData];
   // [self.tableView reloadData];
 
    
}
-(void)searchData{
    
    self.fetchedrecordsarray=nil;
    NSPredicate *resultspredicate=[NSPredicate predicateWithFormat:@"SELF contains [search] %@",self.searchBar.text];
    self.fetchedrecordsarray=[[self.fetchedrecordsarray filteredArrayUsingPredicate:resultspredicate]mutableCopy];
    
    
  
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchData];
}
-(IBAction)segmentUpdate:(id)sender
{
    
    if (_segControl.selectedSegmentIndex==0)
    {
        _uilabel.text=@"Completed";
        [self tableView];
        NSLog(@"Yes");
    }
    else
    {
        _uilabel.text=@"Reading";
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.tableView) {
        return [self.fetchedrecordsarray count];
    }
    else
    {
        [self searchData];
        return [self.fetchedrecordsarray count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    BookDetails *bookdet=[self.fetchedrecordsarray objectAtIndex:indexPath.row];
    NSString *str=[NSString stringWithFormat:@"%@",bookdet.pagesread];
    NSString *str1=[NSString stringWithFormat:@"%@",bookdet.totalpages];
    
    if ([str isEqualToString:str1])
    {
       cell.textLabel.text=[NSString stringWithFormat:@"Book-%@  Completed",bookdet.bookname];
        NSLog(@"Completed");
    }
  else
    {
    cell.textLabel.text=[NSString stringWithFormat:@"Book-%@    Not Completed",bookdet.bookname];
        NSLog(@"Reading");
    }
    
//    if (!cell) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    }

    // Configure the cell...
//    if (tableView==self.tableView)
//    {
//        cell.textLabel.text=[NSString stringWithFormat:@"%@",bookdet.bookname];
//    }
//    else{
////        cell.textLabel.text=@"";
////        cell.textLabel.text=[NSString stringWithFormat:@"Book-%@",bookdet.bookname];
//    }
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
