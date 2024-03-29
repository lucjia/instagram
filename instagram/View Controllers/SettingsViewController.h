//
//  SettingsViewController.h
//  instagram
//
//  Created by lucjia on 7/11/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) UIImage *resizedImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;
@property (weak, nonatomic) IBOutlet UIButton *bioButton;

@end

NS_ASSUME_NONNULL_END
