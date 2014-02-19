//
//  SegmentViewController.m
//  bookdetails
//
//  Created by BSA Univ15 on 17/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import "SegmentViewController.h"
#import "BookDetails.h"
#import "UpdatePage.h"
#import "AppDelegate.h"
#import "BookRecordViewController.h"

@interface SegmentViewController ()
@property (nonatomic,strong)NSArray* fetchedrecordsarray;
@end

@implementation SegmentViewController

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
   // [self.tableView reloadData];
 
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.fetchedrecordsarray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    BookDetails *bookdet=[self.fetchedrecordsarray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[NSString stringWithFormat:@"Book-%@",bookdet.bookname];
    // Configure the cell...

     return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
