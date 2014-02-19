//
//  Custom.m
//  bookdetails
//
//  Created by BSA Univ15 on 17/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import "Custom.h"

@implementation Custom
@synthesize booknameLabel,authornameLabel;

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
