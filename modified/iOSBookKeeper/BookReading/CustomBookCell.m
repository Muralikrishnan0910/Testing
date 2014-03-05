//
//  CustomBookCell.m
//  BookReading
//
//  Created by Thabib on 24/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "CustomBookCell.h"

@implementation CustomBookCell
@synthesize bookNameLabel,authorNameLabel,ssdate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
