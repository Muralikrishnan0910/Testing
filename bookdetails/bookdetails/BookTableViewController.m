//
//  BookTableViewController.m
//  bookdetails
//
//  Created by BSA Univ15 on 13/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import "BookTableViewController.h"
#import "BookDetails.h"
#import "AppDelegate.h"
#import "BookRecordViewController.h"

@interface BookTableViewController ()
- (IBAction)backButton:(id)sender;
@property (nonatomic,strong)NSArray* fetchedrecordsarray;
@end

@implementation BookTableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.fetchedrecordsarray=[appDelegate getAllBooks];
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
    return [self.fetchedrecordsarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BookCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    BookDetails *bookdet=[self.fetchedrecordsarray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[NSString stringWithFormat:@"Book-%@,Author-%@ Total Pages-%@",bookdet.bookname,bookdet.authorname,bookdet.totalpages];
    // Configure the cell...
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"Pages Reads-%@",bookdet.pagesread];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1
    BookRecordViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewControllerIdentifier"];
    //3
    detailController.selectedbook=[self.fetchedrecordsarray objectAtIndex:indexPath.row];
    //2
    [self.navigationController pushViewController:detailController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)backButton:(id)sender
{
[self dismissViewControllerAnimated:YES completion:Nil];
}
@end
