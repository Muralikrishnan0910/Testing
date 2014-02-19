//
//  SegmentViewController.h
//  bookdetails
//
//  Created by BSA Univ15 on 17/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
}

@end
