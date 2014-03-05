//
//  settingViewController.m
//  testing
//
//  Created by BSA Univ21 on 11/02/14.
//  Copyright (c) 2014 BSA Univ21. All rights reserved.
//

#import "settingViewController.h"
#import "menuViewController.h"
#import "ViewController.h"
@interface settingViewController ()

@end

@implementation settingViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}
- (IBAction)pushtohome3:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationIdentifier"] animated:YES completion:nil];

}

- (IBAction)pushtoMenu:(id)sender
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"] animated:YES completion:nil];


}

@end
