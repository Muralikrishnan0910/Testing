//
//  excerptViewController.h
//  BookReading
//
//  Created by BSA Univ15 on 26/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface excerptViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UISegmentedControl *segcontrol;
}
@property(nonatomic,retain)IBOutlet UISegmentedControl *segcontrol;
-(IBAction)segmentUpdate:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *pickview;
@property (weak, nonatomic) IBOutlet UILabel *completedLabel;

- (IBAction)backButton:(id)sender;


@end
