//
//  menuViewController.h
//  testing
//
//  Created by BSA Univ21 on 07/02/14.
//  Copyright (c) 2014 BSA Univ21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuViewController : UIViewController<UITableViewDataSource>
{
    NSArray *data;
}


@property(nonatomic,retain) NSArray *data;
@property(nonatomic) int index;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

- (IBAction)pushtobook:(id)sender;

- (void)pushtoaddbook;
- (void)pushtostatus1;
- (void)pushtosetting1;
- (void)pushtoupdate1;
- (void)back;
@end
