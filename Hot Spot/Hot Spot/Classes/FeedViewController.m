//
//  FeedViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 06/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "FeedViewController.h"

#import <UIStoryboard+MainStoryboard.h>
#import "LocalizedMediaStreamViewController.h"
#import "LocalizedMedia.h"
#import "User.h"

@interface FeedViewController ()

- (void)getFeed;

@property (weak, nonatomic) LocalizedMediaStreamViewController *embedLocalizedMediaStreamViewController;
@property (nonatomic) NSArray *mediaList;

@end

@implementation FeedViewController

#pragma mark - Custom methods

- (void)getFeed {
    [[User CurrentUser] getFeed:^(id responseObject) {
        self.mediaList = responseObject[@"mediaList"];
        [self.embedLocalizedMediaStreamViewController.collectionView reloadData];
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

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self getFeed];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embedLocalizedMediaStream"]) {
        self.embedLocalizedMediaStreamViewController = segue.destinationViewController;
        self.embedLocalizedMediaStreamViewController.delegate = self;
    }
}

#pragma mark - LocalizedMediaStreamDelegate

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
