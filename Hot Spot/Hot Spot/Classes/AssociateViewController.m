//
//  AssociateViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "AssociateViewController.h"

#import "Instagram.h"
#import "User.h"
#import "RootViewController.h"

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
                                                          if (error == nil) {
                                                              [[User CurrentUser] associate:accessToken
                                                                                    success:^(id responseObject) {
                                                                                        [(RootViewController *)self.navigationController goToLogged];
                                                                                        sender.enabled = YES;
                                                                                    }
                                                                                    failure:^(NSInteger statusCode, NSError *error, id responseObject) {
                                                                                        //TODO: statusCode
                                                                                        [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                                    message:error.localizedDescription
                                                                                                                   delegate:nil
                                                                                                          cancelButtonTitle:@"OK"
                                                                                                          otherButtonTitles:nil] show];
                                                                                        sender.enabled = YES;
                                                                                    }];
                                                          } else {
                                                              [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                                          message:error.localizedDescription
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil] show];
                                                              sender.enabled = YES;
                                                          }
                                                      }];
}

@end
