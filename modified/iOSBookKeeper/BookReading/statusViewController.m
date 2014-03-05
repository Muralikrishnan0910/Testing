//
//  statusViewController.m
//  testing
//
//  Created by BSA Univ21 on 11/02/14.
//  Copyright (c) 2014 BSA Univ21. All rights reserved.
//

#import "statusViewController.h"
#import "menuViewController.h"
#import "ViewController.h"
#import "CustomBookCell.h"
#import "CoredataManager.h"
#import "Book.h"
#import "UpdatePage.h"

@interface statusViewController ()

@property(nonatomic,strong)CoredataManager *CDMobj;
@property(nonatomic,strong)UpdatePage *UpdatePageobj;
@property(nonatomic,strong)NSManagedObjectContext *managedobjectcontext;

@property(nonatomic,strong)Book *bookobj;

@property(nonatomic,strong)NSArray *bookData;

@end

@implementation statusViewController
@synthesize CDMobj,bookData,UpdatePageobj;

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
    self.managedobjectcontext = CDMobj.managedObjectContext;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    CustomBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    if (cell==nil) {
//        cell = [[CustomBookCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
    
   
   self.bookobj =  [bookData objectAtIndex:indexPath.row];
    
    
    
    
    cell.bookNameLabel.text = self.bookobj.bookName;
    cell.authorNameLabel.text = self.bookobj.authorName;
//    cell.ProgressSlider.maximumValue =  [self.bookobj.totalPages floatValue];
//    cell.ProgressSlider.minimumValue = [self.bookobj.pagesCompleted floatValue];
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //    1
        [tableView beginUpdates];
        // Delete the row from the data source
        
        //    2
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //    3
        [self.managedobjectcontext deleteObject:[self.bookData objectAtIndex:indexPath.row]];
        NSError *error;
        if (![self.managedobjectcontext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        //    4
        
        
        self.bookData = [CDMobj getAllBookRecords];
        NSLog(@"indexpath: %@", indexPath);
        //    5
        [tableView endUpdates];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UpdatePageobj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"UpdatePage"];
//    [UpdatePageobj setBookname:self.bookobj.bookName];
//    [UpdatePageobj setAuthorname:self.bookobj.authorName];
//    [UpdatePageobj setTotalpage:[NSString stringWithFormat:@"%@",self.bookobj.totalPages]];
//    [self presentViewController:UpdatePageobj animated:NO completion:^void{}];
    
    
    UpdatePageobj =[self.storyboard instantiateViewControllerWithIdentifier:@"UpdatePageIdentifier"];
    
    UpdatePageobj=[self.bookData objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:UpdatePageobj animated:YES];
    
}



- (IBAction)pushtohome2:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"] animated:YES completion:nil];
    
    //[self presentModalViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"] animated:NO];
}
- (IBAction)Pushtomenu:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:YES completion:nil];
    //[self presentModalViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:NO];
}

@end
