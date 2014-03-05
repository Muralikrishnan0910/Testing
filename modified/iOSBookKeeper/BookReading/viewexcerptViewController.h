//
//  viewexcerptViewController.h
//  BookReading
//
//  Created by BSA Univ20 on 04/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
@interface viewexcerptViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)Book *selectedbook;
@property(nonatomic,strong) NSString *strcpy;
@property(nonatomic,strong)  NSString *againcpy;
@end
