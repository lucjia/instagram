//
//  DetailsViewController.h
//  instagram
//
//  Created by lucjia on 7/10/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

NS_ASSUME_NONNULL_END
