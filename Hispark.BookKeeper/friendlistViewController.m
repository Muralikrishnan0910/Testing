//
//  friendlistViewController.m
//  Book Keeper
//
//  Created by BSA univ 16 on 16/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "friendlistViewController.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"
@interface friendlistViewController ()
<FBFriendPickerDelegate,
UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *userInfoTextView;




@property (strong, nonatomic) IBOutlet UIView *myview;
@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *selectFriendsButton;
@property(unsafe_unretained,nonatomic)IBOutlet UIButton *selectgroup;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton  *sendRequestButton;

@property (retain, nonatomic) UISearchBar *searchBar;
@property (retain, nonatomic) NSString *searchText;
@end

@implementation friendlistViewController
@synthesize selectFriendsButton;
@synthesize sendRequestButton;
@synthesize userInfoTextView;
@synthesize loginView;
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

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Berlin Sans FB" size:30];
    //label.shadowColor = [UIColor redColor];
    
    label.textColor = [UIColor colorWithRed:171/255.0 green:36/255.0 blue:44/255.0 alpha:1.0];
    self.navigationItem.titleView = label;
    label.text = @"Friend List";
    [label sizeToFit];
    
    
    // Slidebar Code
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,35,28);
    [button setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    button.tintColor = [UIColor colorWithRed:171/255.0 green:36/255.0 blue:44/255.0 alpha:1.0];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button ];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Add image for Navigation Bar
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"navigation"] forBarMetrics: UIBarMetricsDefault];
   
}
- (void) handlePickerDone
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)addSearchBarToFriendPickerView
{
    if (self.searchBar == nil) {
        CGFloat searchBarHeight = 44.0;
        self.searchBar =
        [[UISearchBar alloc]
         initWithFrame:
         CGRectMake(0,0,
                    self.view.bounds.size.width,
                    searchBarHeight)];
        self.searchBar.autoresizingMask = self.searchBar.autoresizingMask |
        UIViewAutoresizingFlexibleWidth;
        self.searchBar.delegate = self;
        self.searchBar.showsCancelButton = YES;
        
        [self.friendPickerController.canvasView addSubview:self.searchBar];
        CGRect newFrame = self.friendPickerController.view.bounds;
        newFrame.size.height -= searchBarHeight;
        newFrame.origin.y = searchBarHeight;
        self.friendPickerController.tableView.frame = newFrame;
    }
}
- (void) handleSearch:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    self.searchText = searchBar.text;
    [self.friendPickerController updateView];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (BOOL)friendPickerViewController:(FBFriendPickerViewController *)friendPicker
                 shouldIncludeUser:(id<FBGraphUser>)user
{
    // If there is a search query, filter the friend list based on this.
    if (self.searchText && ![self.searchText isEqualToString:@""]) {
        NSRange result = [user.name
                          rangeOfString:self.searchText
                          options:NSCaseInsensitiveSearch];
        if (result.location != NSNotFound) {
            // If friend name matches partially, show the friend
            return YES;
        } else {
            // If no match, do not show the friend
            return NO;
        }
    } else {
        // If there is no search query, show all friends.
        return YES;
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    // Trigger the search
    [self handleSearch:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    // Clear the search query and dismiss the keyboard
    self.searchText = nil;
    [searchBar resignFirstResponder];
}

#pragma mark - LoginView Delegate Methods
/*
 * Handle the logged in scenario
 */
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.selectFriendsButton.hidden = NO;
    self.sendRequestButton.hidden=NO;
}

/*/Users/bsauniv16/Desktop/Hispark.BookKeeper/Hispark.BookKeeper/Base.lproj/Main.storyboard
 * Handle the logged out scenario
 */
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.selectFriendsButton.hidden = YES;
    self.sendRequestButton.hidden=YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectGroupButtonAction:(id)sender
{
//    NSURL *theURL = [NSURL URLWithString:@"/100007926850464?fields=id,name,groups"];
//    [[UIApplication sharedApplication] openURL:theURL];
    
  self.userInfoTextView.hidden = NO;
    // Fetch user data
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                       id<FBGraphUser> user,
                                       NSError *error) {
         if (!error) {
             NSString *userInfo = @"";
             
             // Example: typed access (name)
             // - no special permissions required
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"Name: %@\n\n",
                          user.name]];
             
             // Example: typed access, (birthday)
             // - requires user_birthday permission
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"Birthday: %@\n\n",
                          user.birthday]];
             
             // Example: partially typed access, to location field,
             // name key (location)
             // - requires user_location permission
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"Location: %@\n\n",
                          user.location[@"name"]]];
             
             // Example: access via key (locale)
             // - no special permissions required
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"Locale: %@\n\n",
                          user[@"locale"]]];
             
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"Groups: %@\n\n",
                          user[@"groups"]]];
             
             // Example: access via key for array (languages)
             // - requires user_likes permission
             if (user[@"languages"]) {
                 NSArray *languages = user[@"languages"];
                 NSMutableArray *languageNames = [[NSMutableArray alloc] init];
                 for (int i = 0; i < [languages count]; i++) {
                     languageNames[i] = languages[i][@"name"];
                 }
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"Languages: %@\n\n",
                              languageNames]];
             }
             
             if (user[@"groups"]) {
                 NSArray *groups=user[@"groups"];
                 NSMutableArray *groupNames=[[NSMutableArray alloc]init];
                 for (int i=0; i<[groups count]; i++) {
                     groupNames[i]=groupNames[i][@"name"];
                 }
                 userInfo=[userInfo stringByAppendingString:[NSString stringWithFormat:@"Groups:%@\n\n",groupNames]];
             }
             
             // Display the user info
             self.userInfoTextView.text = userInfo;
         }
     }];
  
}

- (IBAction)selectFriendsButtonAction:(id)sender {
    if (self.friendPickerController == nil) {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Select Friends";
        self.friendPickerController.delegate = self;
    }
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    
    // Present the friend picker
    [self presentViewController:self.friendPickerController
                       animated:YES
                     completion:^(void){
                         [self addSearchBarToFriendPickerView];
                     }
     ];
}
- (void)facebookViewControllerCancelWasPressed:(id)sender
{
    NSLog(@"Friend selection cancelled.");
    [self handlePickerDone];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender
{
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        NSLog(@"Friend selected: %@", user.name);
    }
    [self handlePickerDone];
}
- (IBAction)sendrequestbutton:(id)sender
{
    AppDelegate *appDelegate =
    (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if (FBSession.activeSession.isOpen) {
        [appDelegate sendRequest];
    }
}


@end
