//
//  PostViewController.h
//  instagram
//
//  Created by lucjia on 7/9/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostViewControllerDelegate

- (void)didPost:(Post *)post;

@end

@interface PostViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<PostViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
