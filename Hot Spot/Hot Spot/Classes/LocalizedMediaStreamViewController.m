//
//  LocalizedMediaStreamViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 05/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "LocalizedMediaStreamViewController.h"

#import "LocalizedMediaStreamCell.h"
#import "LocalizedMedia.h"

@interface LocalizedMediaStreamViewController ()

@end

@implementation LocalizedMediaStreamViewController

#pragma mark - UIViewController

/*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 [segue destinationViewController]
 }
 */

#pragma mark - UICollectionViewController

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfLocalizedMedia)]) {
        return [self.delegate numberOfLocalizedMedia];
    } else {
        [NSException raise:NSInternalInconsistencyException format:@"Attribute delegate not set"];
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LocalizedMediaStreamCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LocalizedMediaStreamCell" forIndexPath:indexPath];
    LocalizedMedia *localizedMedia;

    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfLocalizedMedia)]) {
        localizedMedia = [self.delegate localizedMediaForRow:indexPath.row];
    } else {
        [NSException raise:NSInternalInconsistencyException format:@"Attribute delegate not set"];
    }

    cell.username.text = localizedMedia.username;

    return cell;
}

@end
