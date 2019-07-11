//
//  PostCell.h
//  instagram
//
//  Created by lucjia on 7/9/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

NS_ASSUME_NONNULL_END
