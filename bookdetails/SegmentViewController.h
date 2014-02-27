//
//  SegmentViewController.h
//  bookdetails
//
//  Created by BSA Univ15 on 17/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SegmentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate, UISearchBarDelegate>
{
    IBOutlet UITableView *tableView;
}
@property(nonatomic,retain)IBOutlet UILabel *uilabel;
@property(nonatomic,retain)IBOutlet UISegmentedControl *segControl;
-(IBAction)segmentUpdate:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) NSArray *searchResults;

@end
