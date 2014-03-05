//
//  saveandpubViewController.h
//  BookReading
//
//  Created by BSA Univ15 on 28/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

#import "Book.h"

@interface saveandpubViewController : UIViewController

//{
//    SLComposeViewController *mySLComposerSheet;
//}
@property (weak, nonatomic) IBOutlet UITextField *bookktitle;
@property (weak, nonatomic) IBOutlet UITextField *authortitle;
@property (weak, nonatomic) IBOutlet UITextField *Quote;
@property (strong, nonatomic) IBOutlet UITextView *viewtext;
@property (weak, nonatomic) IBOutlet UITextField *bkNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *authrNameLabel;
- (IBAction)posttofbButton:(id)sender;

@property(nonatomic,strong)Book *selectedbook;
@property(strong,nonatomic) NSString *str;
@property(strong,nonatomic) NSString *str1;
@end
