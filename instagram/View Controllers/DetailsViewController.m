//
//  DetailsViewController.m
//  instagram
//
//  Created by lucjia on 7/10/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        self.postImageView.image = [UIImage imageWithData:data];
    }];
    
    self.usernameLabel.text = self.post.userID;
    NSLog(@"%@", self.post.userID);
    self.captionTextView.text = self.post.caption;
    
    // Format date string
    NSDate *originalDate = self.post.createdAt;
    NSString *createdAtString = [NSString stringWithFormat:@"%@", [originalDate timeAgoSinceNow]];
    NSLog(@"%@", createdAtString);
    
    self.timeLabel.text = createdAtString;
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
