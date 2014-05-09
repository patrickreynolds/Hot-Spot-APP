//
//  LocalizedMediaStreamViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 05/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "LocalizedMediaStreamViewController.h"

#import "HotSpot.h"
#import "LocalizedMediaStreamCell.h"
#import "LocalizedMedia.h"

@interface LocalizedMediaStreamViewController ()

@end

@implementation LocalizedMediaStreamViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    if (self.delegate) {
        if ([self.delegate isKindOfClass:([self class])]) {
            self.title = self.hotspot.name;
        }
    } else {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Attribute delegate not set"];
    }
}

#pragma mark - UICollectionViewController

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfLocalizedMedia)]) {
        return [self.delegate numberOfLocalizedMedia];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LocalizedMediaStreamCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LocalizedMediaStreamCell"
                                                                               forIndexPath:indexPath];
    LocalizedMedia *localizedMedia;

    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfLocalizedMedia)]) {
        localizedMedia = [self.delegate localizedMediaForRow:indexPath.row];
    } else {
        return nil;
    }

    cell.username.text = localizedMedia.username;

    return cell;
}

- (NSInteger)numberOfLocalizedMedia {
    return 10;
}

- (LocalizedMedia *)localizedMediaForRow:(NSInteger)row {
    LocalizedMedia *localizedMedia = [LocalizedMedia new];

    localizedMedia.username = [NSString stringWithFormat:@"Username %d", row];

    return localizedMedia;
}

@end
