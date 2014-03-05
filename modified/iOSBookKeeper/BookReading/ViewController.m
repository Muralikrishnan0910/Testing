//
//  ViewController.m
//  testing
//
//  Created by BSA Univ21 on 07/02/14.
//  Copyright (c) 2014 BSA Univ21. All rights reserved.
//

#import "ViewController.h"
#import "menuViewController.h"
#import "excerptViewController.h"
#import "statusViewController.h"
#import "menuViewController.h"
#import "ViewController.h"
#import "CustomBookCell.h"
#import "CoredataManager.h"
#import "Book.h"
#import "UpdatePage.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *mytableview;

@property(nonatomic,strong)CoredataManager *CDMobj;
@property(nonatomic,strong)UpdatePage *UpdatePageobj;
@property(nonatomic,strong)NSManagedObjectContext *managedobjectcontext;

@property(nonatomic,strong)Book *bookobj;
@property(nonatomic,strong)NSArray *bookData;


@property(nonatomic,strong)NSNumber *totpge;
@property(nonatomic,strong)NSNumber *pgecmp;

@end

@implementation ViewController
@synthesize CDMobj,bookData,UpdatePageobj,mytableview;

@synthesize totpge,pgecmp;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CDMobj = [[CoredataManager alloc]init];
    bookData = [CDMobj getAllBookRecords];
    UpdatePageobj = [[UpdatePage alloc]init];
    self.managedobjectcontext = CDMobj.managedObjectContext;
    
    [mytableview reloadData];
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated
{  [super viewDidAppear:YES];
    //[mytableview reloadData];
    
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
    
    
    CustomBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell = [[CustomBookCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    self.bookobj =  [bookData objectAtIndex:indexPath.row];
    totpge=self.bookobj.totalPages;
    pgecmp=self.bookobj.pagesCompleted;
   
    
    cell.slider.maximumValue=[self.bookobj.totalPages floatValue];
    cell.slider.minimumValue=0;
    cell.slider.value=[self.bookobj.pagesCompleted floatValue];
    
    cell.bookNameLabel.text=self.bookobj.bookName;
    cell.authorNameLabel.text=self.bookobj.authorName;
    return cell;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushTomenu:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:YES completion:nil];
}

//- (IBAction)addexcerptButton:(id)sender
//{
//    
//
//}
@end
