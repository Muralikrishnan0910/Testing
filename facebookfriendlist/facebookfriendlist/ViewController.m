//
//  ViewController.m
//  facebookfriendlist
//
//  Created by BSA univ 16 on 28/03/14.
//  Copyright (c) 2014 BSA univ 16. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *friendsarray;
    NSArray *groupmembersarray;
    NSMutableArray *commonfriends;
}
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (nonatomic,strong)fbgroup *fbobj;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    FBLoginView *login=[[FBLoginView alloc]initWithReadPermissions:@[@"basic_info",@"email",@"user_likes",@"read_mailbox",@"user_groups"]];
    login.delegate=self;
    [self.view addSubview:login];
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    self.usernameLabel.text = user.name;
    
    
    NSLog(@"Logged In User Name--->%@",self.usernameLabel.text);
    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fbfriendsbutton:(id)sender
{
    NSString *userid=@"100007926850464";
    NSString *path=[NSString stringWithFormat:@"%@/friends",userid];
    [FBRequestConnection startWithGraphPath:path parameters:NULL HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection,id result,NSError *error){
        if (!error) {
            NSLog(@"Result is %@",result);
            
            FBGraphObject *post=result;
            NSMutableDictionary *dictionary=post;
            NSArray *dict=[dictionary objectForKey:@"data"];
            NSArray *dict1=[dict valueForKey:@"id"];
            
            friendsarray=[NSArray arrayWithArray:dict1];
            
            NSLog(@"friendsid %@",[friendsarray description]);
           // [self comparingarraylist];
        }

    }];
    
}
-(void)comparingarraylist
{
    commonfriends=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[groupmembersarray count]; i++)
    {
        for (int j=0; j<[friendsarray count]; j++)
        {
            [groupmembersarray objectAtIndex:i];
            if ([[groupmembersarray objectAtIndex:i] isEqual:[friendsarray objectAtIndex:j]])
            {
                [commonfriends addObject:groupmembersarray[i]];
            }
        }
    }
    NSLog(@"Common Friend List--->%@",commonfriends);
}
- (IBAction)fbgroupsbutton:(id)sender
{
    NSString *userid=@"100007926850464";
    NSString *path=[NSString stringWithFormat:@"%@/groups",userid];
    [FBRequestConnection startWithGraphPath:path parameters:NULL HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection,id result,NSError *error){
        if (!error) {
           
            NSLog(@"Result is %@",result);
            
            FBGraphObject *post=result;
            NSMutableDictionary *dictionary=post;
            NSArray *dict=[dictionary objectForKey:@"data"];
            
            Group=[[NSMutableArray alloc]init];
            for (int i=0; i<[dict count];i++) {
                fbgroup *obj=[[fbgroup alloc]init];
                NSDictionary *diction=[dict objectAtIndex:i];
                [obj setUserID:[diction objectForKey:@"id"]];
                [obj setUserName:[diction objectForKey:@"name"]];
                 [Group addObject:obj];
                 
                [tableview reloadData];
            }
            
            NSArray *dict1=[dict valueForKey:@"id"];
            groupmembersarray=[NSArray arrayWithArray:dict1];
           
        }
    }];
    NSLog(@"groupid----->%@",[groupmembersarray description]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


// Customize the number of rows in the table view.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [Group count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    
    // Set up the cell...
//    FBGroup *tempOBj=[addGroup objectAtIndex:indexPath.row];
//    
//    cell.textLabel.text =tempOBj.groupName ;
    fbgroup *obj=[Group objectAtIndex:indexPath.row];
    cell.textLabel.text=obj.userName;

    
    return cell;
    
}

- (IBAction)commonfriendsbutton:(id)sender
{
    [self comparingarraylist];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _fbobj=[Group objectAtIndex:indexPath.row];
    
    [self groupmembers];
}
-(void)groupmembers
{
    NSString *grpmem=_fbobj.userID;
    NSString *path=[NSString stringWithFormat:@"%@/members",grpmem];
    
    [FBRequestConnection startWithGraphPath:path parameters:NULL HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error){
        if (!error) {
            FBGraphObject *post=result;
            
            NSMutableDictionary *dictionary=post;
            NSArray *dict=[dictionary objectForKey:@"data"];
            NSArray *dict1=[dict valueForKey:@"id"];
            groupmembersarray=[NSArray arrayWithArray:dict1];
            NSLog(@"members id %@",[groupmembersarray description]);
        }
    }];
    [self fbfriendsbutton:self];
}
@end
