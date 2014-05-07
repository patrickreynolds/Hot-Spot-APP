//
//  LocalizedMediaStreamViewController.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 05/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

@class LocalizedMedia;

@protocol LocalizedMediaStreamDelegate <NSObject>

@required
- (NSInteger)numberOfLocalizedMedia;
- (LocalizedMedia *)localizedMediaForRow:(NSInteger)row;

@end

@interface LocalizedMediaStreamViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) id<LocalizedMediaStreamDelegate> delegate;

@end
