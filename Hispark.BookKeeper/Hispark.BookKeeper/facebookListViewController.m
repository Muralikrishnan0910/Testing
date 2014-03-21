//
//  facebookListViewController.m
//  Book Keeper
//
//  Created by BSA univ 16 on 20/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "facebookListViewController.h"
#import<FacebookSDK/FacebookSDK.h>

@interface facebookListViewController ()
{
    NSDictionary *dict3;
}
@property(nonatomic,strong)fbgroup *tempObj;
@end

@implementation facebookListViewController

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
    // Dispose of any resources that can be recreated.
}

- (IBAction)fbfriends:(id)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Sharing Tutorial", @"name",
                                   @"Build great social apps and get more installs.", @"caption",
                                   @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                   @"https://developers.facebook.com/docs/ios/share/", @"link",
                                   @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                   nil];
    NSString *srt5 =@"100007926850464";
    NSString *url5=[NSString stringWithFormat:@"%@/friends",srt5];
    [FBRequestConnection startWithGraphPath:url5
                                 parameters:params
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Link posted successfully to Facebook
                                  NSLog([NSString stringWithFormat:@"result: %@", result]);
                              } else {
                                  // An error occurred, we need to handle the error
                                  // See: https://developers.facebook.com/docs/ios/errors
                                  NSLog([NSString stringWithFormat:@"%@", error.description]);
                              }
                          }];
}

- (IBAction)fbgroups:(id)sender
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   @"Sharing Tutorial", @"name",
//                                   @"Build great social apps and get more installs.", @"caption",
//                                   @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
//                                   @"https://developers.facebook.com/docs/ios/share/", @"link",
//                                   @"http://i.imgur.com/g3Qc1HN.png", @"picture",
//                                   nil];
//    NSString *srt5 =@"100007926850464";
//    NSString *url5=[NSString stringWithFormat:@"%@/groups",srt5];
//    [FBRequestConnection startWithGraphPath:url5
//                                 parameters:NULL
//                                 HTTPMethod:@"GET"
//                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                              if (!error) {
//                                  // Link posted successfully to Facebook
//                                  NSLog([NSString stringWithFormat:@"result: %@", result]);
//                              } else {
//                                  // An error occurred, we need to handle the error
//                                  // See: https://developers.facebook.com/docs/ios/errors
//                                  NSLog([NSString stringWithFormat:@"%@", error.description]);
//                              }
//                          }];
  
    
    if ([FBSession.activeSession isOpen])
    {
        
        //NSMutableDictionary *DictStore=[[NSMutableDictionary alloc]init];
        NSString *str1=@"100007926850464";
        NSString *url1 = [NSString stringWithFormat:@"%@/groups",str1];
        
        [FBRequestConnection startWithGraphPath:url1
                                     parameters:NULL
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                  int likeCount=0;
                                  if (!error) {
                                      
                                      FBGraphObject *postDetails = result;
                                      NSLog(@"----->%@",postDetails);
                                      // Link posted successfully to Facebook
                                      NSMutableDictionary *dictionary = postDetails;
                                      NSArray *dict2 =[dictionary objectForKey:@"data"];
                                      
                                      NSLog(@"LikesKey----->%@",[dictionary objectForKey:@"data"]);
                                      addGroup=[[NSMutableArray alloc]init];
                                      for (int i=0; i<dict2.count; i++) {
                                         fbgroup *obj=[[fbgroup alloc]init];
                                          NSLog(@"-----%@",[dict2 objectAtIndex:i] );
                                          
                                          NSDictionary *dict4 = [dict2 objectAtIndex:i];
                                          NSLog(@"-----000%@",[dict4 objectForKey:@"name"]);
                                          [obj setGroupId:[dict4 objectForKey:@"id"]];
                                          [obj setGroupName:[dict4 objectForKey:@"name"]];
                                          
                                          [addGroup addObject:obj];
                                          likeCount++;
                                          
                                      }
                                      [tableView reloadData];
                                      
                                      NSLog(@"likescount-------->%d",likeCount);
                                      // _likeslabel.text=likeCount;
                                      
                                      
                                      
                                  }
                                  else {
                                      // An error occurred, we need to handle the error
                                      // See: https://developers.facebook.com/docs/ios/errors
                                      NSLog([NSString stringWithFormat:@"%@", error.description]);
                                  }
                                  NSLog([NSString stringWithFormat:@"result: %@", result]);
                                  NSLog(@"CountLikes %d", likeCount);
                                  [_likeslabel setText:[NSString stringWithFormat:@"%dlike",likeCount]];
                                  NSMutableDictionary * DictStore=[NSKeyedUnarchiver unarchiveObjectWithFile:DictStore];
                                  // NSLog(@"#### %@", DictStore);
                                  
                              }];
        
        
    }


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


// Customize the number of rows in the table view.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [addGroup count];
    
}



// Customize the appearance of table view cells.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    
    // Set up the cell...
    fbgroup *tempObj=[addGroup objectAtIndex:indexPath.row];
    
    cell.textLabel.text =tempObj.groupName ;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tempObj=[addGroup objectAtIndex:indexPath.row];
    NSLog(@"%@",_tempObj.groupId);
}
@end
