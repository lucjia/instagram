//
//  LogInViewController.m
//  instagram
//
//  Created by lucjia on 7/8/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import "LogInViewController.h"
#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface LogInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.passwordField.secureTextEntry = YES;
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            
            // Create alert
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Log In"
                                                                           message:@"Invalid username or password."
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            // Create a try again action
            UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                     style:UIAlertActionStyleCancel
                                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                                       // Handle cancel response here. Doing nothing will dismiss the view.
                                                                   }];
            // Add the cancel action to the alertController
            [alert addAction:dismissAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            NSLog(@"User logged in successfully");
            
            // Display view controller that needs to shown after successful login
            NSLog(@"Segue to Feed");
            [self performSegueWithIdentifier:@"toFeed" sender:self];
            NSLog(@"Segued");
        }
    }];
}

- (IBAction)didPressRegister:(id)sender {
    [self performSegueWithIdentifier:@"toRegister" sender:self];
}

- (IBAction)didPressLogIn:(id)sender {
    [self loginUser];
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
