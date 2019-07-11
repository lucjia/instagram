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

@interface LogInViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.passwordField.secureTextEntry = YES;
    
    // Transparent - white Gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.gradientView.bounds;
    gradient.colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor colorWithWhite:1 alpha:0].CGColor];
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
    
    // Set buttons
    self.logInButton.backgroundColor = [UIColor whiteColor];
    self.logInButton.layer.cornerRadius = 18;
    self.logInButton.clipsToBounds = YES;
    self.registerButton.backgroundColor = [UIColor whiteColor];
    self.registerButton.layer.cornerRadius = 18;
    self.registerButton.clipsToBounds = YES;
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            
            if ([self.usernameField.text isEqual:@""]) {
                // Create alert
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Log In"
                                                                               message:@"Please enter a username."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                // Create a dismiss action
                UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                        style:UIAlertActionStyleCancel
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                                          // Handle cancel response here. Doing nothing will dismiss the view.
                                                                      }];
                // Add the cancel action to the alertController
                [alert addAction:dismissAction];
                alert.view.tintColor = [UIColor colorWithRed:134.0/255.0f green:43.0/255.0f blue:142.0/255.0f alpha:1.0f];
                [self presentViewController:alert animated:YES completion:nil];
            } else if ([self.passwordField.text isEqual:@""]) {
                // Create alert
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Log In"
                                                                               message:@"Please enter a password."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                // Create a dismiss action
                UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                        style:UIAlertActionStyleCancel
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                                          // Handle cancel response here. Doing nothing will dismiss the view.
                                                                      }];
                // Add the cancel action to the alertController
                [alert addAction:dismissAction];
                alert.view.tintColor = [UIColor colorWithRed:134.0/255.0f green:43.0/255.0f blue:142.0/255.0f alpha:1.0f];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                // Create alert
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Log In"
                                                                               message:@"Invalid username or password."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                // Create a dismiss action
                UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                        style:UIAlertActionStyleCancel
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                                          // Handle cancel response here. Doing nothing will dismiss the view.
                                                                      }];
                // Add the cancel action to the alertController
                [alert addAction:dismissAction];
                alert.view.tintColor = [UIColor colorWithRed:134.0/255.0f green:43.0/255.0f blue:142.0/255.0f alpha:1.0f];
                [self presentViewController:alert animated:YES completion:nil];
            }
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
