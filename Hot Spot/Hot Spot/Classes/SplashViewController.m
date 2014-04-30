//
//  SplashViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "SplashViewController.h"

#import "RootViewController.h"
#import "User.h"
#import "Session.h"

@implementation SplashViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set and show the splash screen
    [self setSplashView];

    RootViewController *rootViewController = (RootViewController *)self.navigationController;

    NSString *sessionToken = [Session sessionToken];
    NSString *userId = [Session userId];
    if ([sessionToken length] && [userId length]) {
        [[User CurrentUser] login:userId
                     sessionToken:sessionToken
                          success:^(id responseObject) {
                              [Session storeSessionToken:responseObject[@"sessionToken"]
                                               andUserId:responseObject[@"userId"]];
                              [rootViewController goToLogged];
                          }
                          failure:^(NSInteger statusCode, NSError *error, id responseObject) {
                              if (statusCode == 403) {
                                  [Session storeSessionToken:responseObject[@"sessionToken"]
                                                   andUserId:responseObject[@"userId"]];
                                  [rootViewController goToAssociate];
                              } else {
                                  [Session destroySession];
                                  [rootViewController goToLogin];
                              }
                          }];
    } else {
        [rootViewController goToLogin];
    }
}

#pragma mark - Methods

- (void)setSplashView {
    UIImageView *splashView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // Is iPhone 5?
    if ([UIScreen mainScreen].bounds.size.height == 568.0) {
        splashView.image = [UIImage imageNamed:@"LaunchImage-700-568h@2x.png"];
    } else {
        // Is Retina?
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2) {
            splashView.image = [UIImage imageNamed:@"LaunchImage-700@2x.png"];
        } else {
            splashView.image = [UIImage imageNamed:@"LaunchImage-700.png"];
        }
    }

    [self setView:splashView];
}

@end
