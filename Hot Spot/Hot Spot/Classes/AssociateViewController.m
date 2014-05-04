//
//  AssociateViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "AssociateViewController.h"

#import "Instagram.h"

@implementation AssociateViewController

- (IBAction)didTapConnect:(UIButton *)sender {
    if (!sender.isEnabled) {
        return ;
    }
    sender.enabled = NO;
    [[InstagramPlatform sharedPlatform] startSessionWithClientID:@"801cf1d44fcd43f99cbb38781d7cb227"
                                                    clientSecret:@"f768ff10426f4cc2a6a8e6688b45a39f"
                                                       authScope:InstagramPlatformAuthScopeAll
                                                      completion:^(NSString *accessToken, NSError *error) {
                                                          sender.enabled = YES;
                                                          if (error == nil) {
                                                              [[[UIAlertView alloc] initWithTitle:@"Success"
                                                                                          message:[NSString stringWithFormat:@"Instagram access_token: %@", accessToken]
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil] show];
                                                          } else {
                                                              [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                                          message:error.localizedDescription
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil] show];
                                                          }
                                                      }];
}

@end
