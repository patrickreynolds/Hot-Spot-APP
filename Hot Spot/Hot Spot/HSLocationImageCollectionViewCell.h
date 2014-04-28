//
//  HSLocationImageCollectionViewCell.h
//  Hot Spot
//
//  Created by Patrick Reynolds on 3/13/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSLocationImageCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *currentTime;
@property (strong, nonatomic) IBOutlet UILabel *likeCount;

@end
