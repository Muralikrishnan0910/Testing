//
//  facebookListViewController.h
//  Book Keeper
//
//  Created by BSA univ 16 on 20/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fbgroup.h"
@interface facebookListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *addGroup;
    IBOutlet UITableView *tableView;
}
- (IBAction)fbfriends:(id)sender;
- (IBAction)fbgroups:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *likeslabel;

@end
