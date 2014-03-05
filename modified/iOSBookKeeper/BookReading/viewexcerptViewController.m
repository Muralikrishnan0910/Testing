//
//  viewexcerptViewController.m
//  BookReading
//
//  Created by BSA Univ20 on 04/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "viewexcerptViewController.h"
#import "AppDelegate.h"
#import "CustomBookCell.h"
#import "excerptViewController.h"

@interface viewexcerptViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@property(nonatomic,strong)NSManagedObjectContext *managedobjectcontext;
@property (nonatomic,strong)NSArray* fetchedrecordsarray;
@property(nonatomic,strong)Book *sel;
@end

@implementation viewexcerptViewController
@synthesize mytableview,strcpy,againcpy;
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
    self.fetchedrecordsarray=[appDelegate getAllBookRecords];
    againcpy=self.strcpy;
    NSLog(@"123==%@",againcpy);

    //[self process];
    
    [self.mytableview reloadData];

}
//-(void)process
//{
//    NSFetchRequest *request =[[NSFetchRequest alloc]init];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bookName==%@",self.againcpy];
//    
//        NSEntityDescription *exp =[NSEntityDescription entityForName:@"Book" inManagedObjectContext:self.managedobjectcontext];
//      [request setEntity:exp];
//       [request setPredicate:predicate];
//      NSError *error=nil;
//       NSMutableArray *mutableFetchResult=[[self.managedobjectcontext executeFetchRequest:request error:&error]mutableCopy];
//    
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.fetchedrecordsarray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[CustomBookCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
     //Book *bookobje=[self.fetchedrecordsarray objectAtIndex:indexPath.row];
    cell.bookNameLabel.text=self.selectedbook.bookName;
    cell.excerptviewtextView.text=self.selectedbook.addnotes;
    return cell;
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
