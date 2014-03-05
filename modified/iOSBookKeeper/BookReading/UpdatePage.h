//
//  UpdatePage.h
//  BookReading
//
//  Created by Thabib on 24/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"


@interface UpdatePage : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *updatebooktitle;
@property (weak, nonatomic) IBOutlet UITextField *updateauthortitle;
@property (weak, nonatomic) IBOutlet UITextField *updatetotalpages;
@property (weak, nonatomic) IBOutlet UITextField *updatereadtoday;

@property (weak, nonatomic) IBOutlet UITextField *BooknameLabel;
@property (weak, nonatomic) IBOutlet UITextField *AuthorNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *TotalPagesLabel;
@property (weak, nonatomic) IBOutlet UITextField *PagesCompletedField;

@property(nonatomic,strong)Book *selectedbook;
- (IBAction)btn_AddNotes:(id)sender;




@end
