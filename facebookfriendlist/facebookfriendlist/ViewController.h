//
//  ViewController.h
//  facebookfriendlist
//
//  Created by BSA univ 16 on 28/03/14.
//  Copyright (c) 2014 BSA univ 16. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "fbgroup.h"
@interface ViewController : UIViewController<FBLoginViewDelegate,UITableViewDataSource,UITableViewDataSource>
{
    NSMutableArray *Group;
    IBOutlet UITableView *tableview;
}
- (IBAction)fbfriendsbutton:(id)sender;
- (IBAction)fbgroupsbutton:(id)sender;
- (IBAction)commonfriendsbutton:(id)sender;

@end
