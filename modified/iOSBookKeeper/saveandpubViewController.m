//
//  saveandpubViewController.m
//  BookReading
//
//  Created by BSA Univ15 on 28/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//
#import <FacebookSDK/FacebookSDK.h>
#import "saveandpubViewController.h"
#import "AppDelegate.h"
#import "CoredataManager.h"
#import "UpdatePage.h"




@interface saveandpubViewController ()
{
    NSData *text;
    NSManagedObjectContext *context;
}
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property(strong,nonatomic) NSArray *fetch;
@property(nonatomic,strong)CoredataManager *CDMobj;

@property(nonatomic,strong)UpdatePage *upj;

@end

@implementation saveandpubViewController
@synthesize CDMobj,upj,str,str1,bkNameLabel,authrNameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"%@", fontName);
        }
    }
   
    
    
    
    
//    
//    UILabel *myLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//    
//    UIImage *img = [UIImage imageNamed:@"letterText"];
//    CGSize imgSize = myLabel.frame.size;
//    
//    UIGraphicsBeginImageContext( imgSize );
//    [img drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height)];
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
   // myLabel.backgroundColor = [UIColor colorWithPatternImage:newImage];
    self.bookktitle.font=[UIFont fontWithName:@"Steiner" size:40];
    self.authortitle.font=[UIFont fontWithName:@"Steiner" size:40];
    self.Quote.font=[UIFont fontWithName:@"Steiner" size:40];
    self.bkNameLabel.font = [UIFont fontWithName:@"ErasITC-Medium" size:30];
   self.authrNameLabel.font = [UIFont fontWithName:@"ErasITC-Medium" size:30];
    [[self.viewtext layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.viewtext layer] setBorderWidth:2.3];
    [[self.viewtext layer] setCornerRadius:15];
    [super viewDidLoad];
	
    
    // Do any additional setup after loading the view.

    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext=appDelegate.managedObjectContext;
    self.fetch=[appDelegate getAllBookRecords];
    self.bkNameLabel.text=self.str;
    self.authrNameLabel.text=self.str1;
    
}
        
- (IBAction)savetolocal:(id)sender
{
    if (![self.viewtext.text isEqualToString:@""])
        
    {
        for (int i=0; i<[self.fetch count]; i++)
        {
            NSManagedObject *obj=[self.fetch objectAtIndex:i];
            
            NSString *bookname=[obj valueForKey:@"bookName"];
            NSString *authorname=[obj valueForKey:@"authorName"];
            
            //                NSString *savebook1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserMail"];
            //                NSString *savebook2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserMail"];
            
            if([bookname isEqual:self.str]&&[authorname isEqual:self.str1])
            {
                // self.viewtext.text=[obj valueForKey:@"addnotes"];
                NSString *quotetxt=self.viewtext.text;
                NSLog(@"=====%@",quotetxt);
                text=[quotetxt dataUsingEncoding:NSUTF8StringEncoding];
                NSMutableData *body=[text mutableCopy];
                //[body appendData:text];//[text mutableCopy];
             //  NSLog(@"array%@",body);

                [obj setValue:body forKey:@"addnotes"];
                
                
                
                NSError *error;
                if (![self.managedObjectContext save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
            }
        }
        
    }
    // NSLog(@"sssssssss%@",[self.fetch description]);
}



- (IBAction)pushtohomescreen:(id)sender
{
     [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationIdentifier"] animated:YES completion:nil];
    

}
- (IBAction)pushtomenuscreen:(id)sender
{
     [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:YES completion:nil];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (IBAction)postOnFacebook:(id)sender
//{
//    mySLComposerSheet = [[SLComposeViewController alloc] init];
//    mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//    [mySLComposerSheet setInitialText:@""];
//    [self presentViewController:mySLComposerSheet animated:YES completion:NULL];
//}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)string
{
    if([string isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    
    return YES;
}
- (IBAction)posttofbButton:(id)sender
{
    NSString *strt=_viewtext.text;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  strt, @"message",
                                   @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                   nil];
    
    // Make the request
    if ([FBSession.activeSession isOpen])
    {
        [FBRequestConnection startWithGraphPath:@"/me/feed"
                                     parameters:params
                                     HTTPMethod:@"POST"
                              completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                  if (!error) {
                                      // Link posted successfully to Facebook
                                      NSLog([NSString stringWithFormat:@"result: %@", result]);
                                  } else {
                                      NSLog([NSString stringWithFormat:@"%@", error.description]);
                                  }
                              }];
    }
}
@end
