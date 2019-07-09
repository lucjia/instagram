//
//  FeedViewController.m
//  instagram
//
//  Created by lucjia on 7/8/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import "FeedViewController.h"
#import "LogInViewController.h"
#import "Parse/Parse.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Loaded feed");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
