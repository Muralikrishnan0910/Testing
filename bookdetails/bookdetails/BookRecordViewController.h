//
//  BookRecordViewController.h
//  bookdetails
//
//  Created by BSA Univ15 on 13/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetails.h"

@interface BookRecordViewController : UIViewController<UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet UITextField *booknameTextfield;
//@property (weak, nonatomic) IBOutlet UITextField *authornameTextfield;
//@property (weak, nonatomic) IBOutlet UITextField *totalpagesTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pagesreadTextfield;
@property (weak, nonatomic) IBOutlet UILabel *booknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authornameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalpagesLabel;

@property(nonatomic,strong)BookDetails *selectedbook;
@end
