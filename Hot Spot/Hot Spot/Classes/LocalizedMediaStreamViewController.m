//
//  LocalizedMediaStreamViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 05/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "LocalizedMediaStreamViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <UIStoryboard+MainStoryboard.h>
#import "User.h"
#import "HotSpot.h"
#import "LocalizedMediaStreamCell.h"
#import "LocalizedMedia.h"
#import "CreateHotSpotViewController.h"

@interface LocalizedMediaStreamViewController ()

- (void)fetchHotSpot;

@property (nonatomic) NSArray *mediaList;

@end

@implementation LocalizedMediaStreamViewController

#pragma mark - Custom methods

- (void)fetchHotSpot {
    [[User CurrentUser] fetchHotSpot:[[NSNumber numberWithDouble:self.hotspot.coordinate.latitude] stringValue]
                                 lng:[[NSNumber numberWithDouble:self.hotspot.coordinate.longitude] stringValue]
                             success:^(id responseObject) {
                                 self.mediaList = responseObject[@"mediaList"];
                                 [self.collectionView reloadData];
                             }
                             failure:^(NSInteger statusCode, NSError *error, id responseObject) {
                                 //TODO: statusCode
                                 [[[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:error.localizedDescription
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil] show];

                             }];
}

- (void)addHotSpot {
    CreateHotSpotViewController *createHotSpotViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CreateHotSpot"];
    createHotSpotViewController.coordinate = self.hotspot.coordinate;
    [self presentViewController:createHotSpotViewController
                       animated:YES
                     completion:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.delegate) {
        if ([self.delegate isKindOfClass:([self class])]) {

            if ([self.hotspot isPreview]) {
                self.title = @"Preview";
                UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                         target:self
                                                                                         action:@selector(addHotSpot)];
                self.navigationItem.rightBarButtonItem = addItem;
            } else {
                self.title = self.hotspot.name;
            }
        }
    } else {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Attribute delegate not set"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([self.delegate isKindOfClass:([self class])]) {
        [self fetchHotSpot];
    }
}

#pragma mark - UICollectionViewController

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (![self.delegate respondsToSelector:@selector(numberOfLocalizedMedia)]) {
        return 0;
    }
    return [self.delegate numberOfLocalizedMedia];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.delegate respondsToSelector:@selector(numberOfLocalizedMedia)]) {
        return nil;
    }
    LocalizedMediaStreamCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LocalizedMediaStreamCell"
                                                                               forIndexPath:indexPath];
    LocalizedMedia *localizedMedia = [self.delegate localizedMediaForRow:indexPath.row];

    [cell.avatar setImageWithURL:[NSURL URLWithString:localizedMedia.avatar]];
    cell.username.text = localizedMedia.username;
    [cell.picture setImageWithURL:[NSURL URLWithString:localizedMedia.picture]];
    cell.createdTime.text = localizedMedia.createdTime;
    cell.likeCount.text = [NSString stringWithFormat:@"Likes: %@", localizedMedia.likeCount];

    return cell;
}

- (NSInteger)numberOfLocalizedMedia {
    return [self.mediaList count];
}

- (LocalizedMedia *)localizedMediaForRow:(NSInteger)row {
    NSDictionary *media = self.mediaList[row];
    LocalizedMedia *localizedMedia = [LocalizedMedia new];

    localizedMedia.avatar = media[@"user"][@"profile_picture"];
    localizedMedia.username = media[@"user"][@"username"];
    localizedMedia.picture = media[@"images"][@"standard_resolution"][@"url"];

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[(NSNumber *)media[@"created_time"] doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd.MM.yyyy 'at' hh.mm a"];
    localizedMedia.createdTime = [formatter stringFromDate:date];

    localizedMedia.likeCount = media[@"likes"][@"count"];

    return localizedMedia;
}

@end
