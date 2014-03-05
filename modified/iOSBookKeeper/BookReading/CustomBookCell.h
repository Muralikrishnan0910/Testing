//
//  CustomBookCell.h
//  BookReading
//
//  Created by Thabib on 24/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBookCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pagesCompletedLabel;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UITextView *excerptviewtextView;

@property (weak, nonatomic) IBOutlet UILabel *bookNameTableLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorNameTableLabel;
@property(strong,nonatomic) IBOutlet UILabel *ssdate;
@end
