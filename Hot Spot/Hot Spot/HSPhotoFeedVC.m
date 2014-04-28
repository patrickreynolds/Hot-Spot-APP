//
//  HSPhotoFeed.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 12/14/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "HSPhotoFeedVC.h"
#import "HSOAuthSignupVC.h"

@interface HSPhotoFeedVC ()

@end

@implementation HSPhotoFeedVC

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.access_token = @"temp"; // *********** avoiding modal access_token request
    if (!self.access_token) {
        NSLog(@"Open Modal.");
        [self getAccesTokenFromModal];
    }
}

- (void)getAccesTokenFromModal
{
    [self performSegueWithIdentifier: @"Get Access Token" sender: self];
}

- (IBAction)foundAccessToken:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[HSOAuthSignupVC class]])
    {
        HSOAuthSignupVC *oauthVC = (HSOAuthSignupVC *)segue.sourceViewController;
        NSString* returnedAccessToken = oauthVC.access_token;
        if (returnedAccessToken) {
            self.access_token = returnedAccessToken;
                NSLog(@"Returned Access Token: %@", self.access_token);
        } else {
            NSLog(@"HSOAuthSignupVC not return an access_token.");
        }
    }
}


@end
