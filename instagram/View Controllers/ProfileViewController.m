//
//  ProfileViewController.m
//  instagram
//
//  Created by lucjia on 7/10/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "PostCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.usernameLabel.text = PFUser.currentUser.username;
    self.bioLabel.text = @"Hi this is bio";
    self.profileImageView.layer.cornerRadius = 63;
    self.profileImageView.clipsToBounds = YES;
//    self.profileImageView = [UIImage imageWithData:data];
    
    [self fetchPosts];
    
    // set 3 images per line
    UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing*(postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (IBAction)didPressSettings:(id)sender {
    [self performSegueWithIdentifier:@"toSettings" sender:nil];
}

- (void)fetchPosts {
    // Construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    postQuery.limit = 20;
    
    // Fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // Do something with the data fetched
            self.postArray = posts;
            
            [self.collectionView reloadData];
        }
        else {
            // Handle error
        }
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    Post *post = self.postArray[indexPath.item];
    
    [post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        cell.postImageView.image = [UIImage imageWithData:data];
    }];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postArray.count;
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
