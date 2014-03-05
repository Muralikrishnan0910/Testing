//
//  menuViewController.m
//  testing
//
//  Created by BSA Univ21 on 07/02/14.
//  Copyright (c) 2014 BSA Univ21. All rights reserved.
//

#import "menuViewController.h"
#import "ViewController.h"
#import "addbookViewController.h"
#import "statusViewController.h"
#import "settingViewController.h"

@interface menuViewController ()

@end

@implementation menuViewController

@synthesize data,index,tableview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [self menuprocess];
    [super viewDidLoad];
	

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
- (void)menuprocess
{
    data=[[NSArray alloc] initWithObjects:@" ",@" ",@" ",nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
cell.textLabel.text=[data objectAtIndex:indexPath.row];
   
    return cell;
}


- (IBAction)backtohome:(id)sender
{
    [self back];
}

- (IBAction)pushtobook:(id)sender
{
    [self pushtoaddbook];
}
- (IBAction)pushtostatus
{
    [self pushtostatus1];
}
- (IBAction)pushtosetting
{
    [self pushtosetting1];
}

- (void)pushtoaddbook
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"AddBookViewController"] animated:YES completion:nil];

}

- (void)pushtostatus1
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"navigationidentity"] animated:YES completion:nil];

}
- (void)pushtosetting1
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"settingViewController"] animated:YES completion:nil];

}

- (void)back
{
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NavigationIdentifier"] animated:YES completion:nil];
}



@end
