//
//  FeedViewController.m
//  instagram
//
//  Created by lucjia on 7/8/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import "FeedViewController.h"
#import "LogInViewController.h"
#import "PostViewController.h"
#import "DetailsViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "Parse/Parse.h"
#import "DateTools.h"

@interface FeedViewController () <PostViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *postArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation FeedViewController : UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Start the activity indicator
    [self.activityIndicator startAnimating];
    
    // refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Image in nav bar
    UIImage *image = [UIImage imageNamed:@"insta"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 30, 30);
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imageView;
    
    // Show last cell above tab bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self fetchPosts];
    [self.tableView reloadData];
}

- (IBAction)didPressLogOut:(id)sender {
    [self logOutUser];
}

- (void)logOutUser {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    NSLog(@"Logged out");
    
    // Set root view controller to be log in screen
    LogInViewController *logInVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LogInViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:logInVC];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)didPressSettings:(id)sender {
    [self performSegueWithIdentifier:@"toSettings" sender:nil];
}

- (void)fetchPosts {
    // Construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // Fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // Do something with the data fetched
            self.postArray = posts;
            
            [self.tableView reloadData];
            
            // Stop the activity indicator
            // Hides automatically if "Hides When Stopped" is enabled
            [self.activityIndicator stopAnimating];
        }
        else {
            // Handle error
        }
        // Tell the refreshControl to stop spinning
        [self.refreshControl endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
    Post *post = self.postArray[indexPath.row];
    cell.post = post;
    
    [post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        cell.postImageView.image = [UIImage imageWithData:data];
    }];
    
    cell.usernameLabel.text = post.userID;
    cell.captionLabel.text = post.caption;
    cell.usernameLabel2.text = post.userID;
    cell.profileImageView.layer.cornerRadius = 20;
    cell.profileImageView.clipsToBounds = YES;
    
    // Format date string
    NSDate *originalDate = post.createdAt;
    NSString *createdAtString = [NSString stringWithFormat:@"%@", [originalDate timeAgoSinceNow]];
    NSLog(@"%@", createdAtString);
    
    cell.timeLabel.text = createdAtString;
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString: @"toDetails"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.postArray[indexPath.row];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

// Infinite Scrolling
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - 60;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            
            [self loadMoreData];
        }
    }
}

// Request more data
-(void)loadMoreData{
    // Construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // Fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // Do something with the data fetched
            for (int i = 0; i < 20; i++) {
//                [self.postArray addObject:@([posts objectAtIndex:i])];
            }
            self.isMoreDataLoading = false;
            [self.tableView reloadData];
            
            // Stop the activity indicator
            // Hides automatically if "Hides When Stopped" is enabled
            [self.activityIndicator stopAnimating];
        }
        else {
            // Handle error
            
        }
        // Tell the refreshControl to stop spinning
        [self.refreshControl endRefreshing];
    }];
}

@end
