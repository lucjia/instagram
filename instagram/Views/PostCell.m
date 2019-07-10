//
//  PostCell.m
//  instagram
//
//  Created by lucjia on 7/9/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postImageView.image = post.image;
    self.usernameLabel.text = post.userID;
    self.captionLabel.text = post.caption;
}

@end
