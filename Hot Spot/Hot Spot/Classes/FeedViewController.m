//
//  FeedViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 06/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "FeedViewController.h"

#import "LocalizedMediaStreamViewController.h"
#import "LocalizedMedia.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

#pragma mark - UIViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embedLocalizedMediaStream"]) {
        LocalizedMediaStreamViewController *localizedMediaStream = segue.destinationViewController;
        localizedMediaStream.delegate = self;
    }
}

#pragma mark - LocalizedMediaStreamDelegate

- (NSInteger)numberOfLocalizedMedia {
    return 0;
}

- (LocalizedMedia *)localizedMediaForRow:(NSInteger)row {
    LocalizedMedia *localizedMedia = [LocalizedMedia new];

    localizedMedia.username = [NSString stringWithFormat:@"Username %d", row];

    return localizedMedia;
}

@end
