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
#import "adddisplayViewController.h"



@interface saveandpubViewController ()<UITextViewDelegate>
{
    
    NSString *strapp;
}
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property(strong,nonatomic) NSArray *fetch;
@property(strong,nonatomic) NSMutableArray *arraysize;
@property(nonatomic,strong)CoredataManager *CDMobj;

@property(nonatomic,strong)UpdatePage *upj;

@end

@implementation saveandpubViewController
@synthesize CDMobj,upj,str,str1,bkNameLabel,authrNameLabel;
static int count=1;
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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext=appDelegate.managedObjectContext;
    self.fetch=[appDelegate getAllBookRecords];
    [self.viewtext.layer setBorderColor:[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.viewtext.layer setBorderWidth:2.0];
    self.viewtext.layer.cornerRadius = 10;
    self.viewtext.clipsToBounds = YES;
    self.arraysize=[[NSMutableArray alloc]init];
    self.bkNameLabel.text=self.str;
    self.authrNameLabel.text=self.str1;
    self.viewtext.delegate=self;
    
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
            
            if([bookname isEqual:self.bkNameLabel.text]&&[authorname isEqual:authrNameLabel.text])
                
            { NSLog(@"string matched  %@=%@",bookname,self.bkNameLabel.text);
                
                NSString *quotetxt=self.viewtext.text;
                NSString *notes=[obj valueForKey:@"addnotes"];
                if (notes == nil)
                {
                    [obj setValue:quotetxt forKey:@"addnotes"];
                }
                else
                {
                NSString *second=[notes stringByAppendingString:@"\n\n"];
                NSString *finalstr=[second stringByAppendingString:quotetxt];
                    
                    count+=1;
                NSLog(@"append=%@",finalstr);
                    
                NSArray *separate=[finalstr componentsSeparatedByString:@"\n\n"];
                NSArray *arraynotes=[[NSArray alloc]initWithObjects:separate,nil];
                    
               NSLog(@"%@",[arraynotes description]);
               NSLog(@"count %d",count);
                   
                [obj setValue:finalstr forKey:@"addnotes"];
                }

                NSError *error;
                if (![self.managedObjectContext save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
            }
        }
        
    }

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

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)string
//{
//    if([string isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//    }
//    
//    return YES;
//}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [self.viewtext resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}
- (IBAction)posttofbButton:(id)sender
{
    NSString *strt=self.viewtext.text;
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
