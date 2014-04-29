//
//  HSLocationImageStreamCollectionViewController.h
//  Hot Spot
//
//  Created by Patrick Reynolds on 3/13/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSLocation.h"

@interface HSLocationImageStreamCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) HSLocation *location;

@end
