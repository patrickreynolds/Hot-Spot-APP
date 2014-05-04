//
//  InstagramPlatform.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 03/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "InstagramPlatform.h"

#import <AFNetworking/AFNetworking.h>
#import "InstagramAuthViewController.h"

NSString * const kInstagramPlatformDefaultRedirectURI = @"instagram-platform://redirect";

#pragma mark - Platform

@interface InstagramPlatform () <InstagramAuthViewControllerDelegate>

@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *redirectURI;

@property (nonatomic, copy) InstagramPlatformSessionCompletion sessionCompletion;

@property (nonatomic, strong) InstagramAuthViewController *authViewController;

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation InstagramPlatform

#pragma mark - Initialization

static InstagramPlatform *_instance = nil;

+ (InstagramPlatform *)sharedPlatform {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[InstagramPlatform alloc] init];
    });

    return _instance;
}

+ (NSString *)basePlatformURL {
    return @"https://api.instagram.com";
}

+ (NSString *)currentPlatformVersion {
    return @"v1";
}

#pragma mark - Auth Flow

- (void)startSessionWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret completion:(InstagramPlatformSessionCompletion)completion {
    [self startSessionWithClientID:clientID
                      clientSecret:clientSecret
                         authScope:InstagramPlatformAuthScopeBasic
                        completion:completion];
}

- (void)startSessionWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret authScope:(InstagramPlatformAuthScope)authScope completion:(InstagramPlatformSessionCompletion)completion {
    [self startSessionWithClientID:clientID
                      clientSecret:clientSecret
                         authScope:authScope
                       redirectURI:kInstagramPlatformDefaultRedirectURI
                        completion:completion];
}

- (void)startSessionWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret authScope:(InstagramPlatformAuthScope)authScope redirectURI:(NSString *)redirectURI completion:(InstagramPlatformSessionCompletion)completion {
    self.sessionCompletion = completion;
    self.clientID = clientID;
    self.clientSecret = clientSecret;
    self.redirectURI = redirectURI;

    NSString *authURLString = [NSString stringWithFormat:@"%@/oauth/authorize/?response_type=code&client_id=%@&scope=%@&redirect_uri=%@", [InstagramPlatform basePlatformURL], self.clientID, [self stringFromAuthScope:authScope], redirectURI];
    self.authViewController = [[InstagramAuthViewController alloc] initWithURL:[NSURL URLWithString:authURLString]
                                                                      delegate:self];
    [self.authViewController show];
}

- (NSString *)stringFromAuthScope:(InstagramPlatformAuthScope)scope {
    NSMutableArray *scopeStrings = [NSMutableArray array];

    if (scope & InstagramPlatformAuthScopeBasic || scope & InstagramPlatformAuthScopeAll) {
        [scopeStrings addObject:@"basic"];
    }
    if (scope & InstagramPlatformAuthScopeComments || scope & InstagramPlatformAuthScopeAll) {
        [scopeStrings addObject:@"comments"];
    }
    if (scope & InstagramPlatformAuthScopeRelationships || scope & InstagramPlatformAuthScopeAll) {
        [scopeStrings addObject:@"relationships"];
    }
    if (scope & InstagramPlatformAuthScopeLikes || scope & InstagramPlatformAuthScopeAll) {
        [scopeStrings addObject:@"likes"];
    }

    return [scopeStrings componentsJoinedByString:@"+"];
}

#pragma mark - Auth View Controller Delegate

- (void)authViewController:(InstagramAuthViewController *)viewController didCompleteWithAuthCode:(NSString *)code {
    NSString *url = [NSString stringWithFormat:@"%@/oauth/access_token", [InstagramPlatform basePlatformURL]];

    [[AFHTTPRequestOperationManager manager] POST:url
                     parameters:@{ @"grant_type": @"authorization_code",
                                   @"client_id": self.clientID,
                                   @"client_secret": self.clientSecret,
                                   @"code": code,
                                   @"redirect_uri": self.redirectURI }
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            self.sessionCompletion(responseObject[@"access_token"], nil);
                        }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            self.sessionCompletion(nil, error);
                        }];
}

- (void)authViewController:(InstagramAuthViewController *)viewController didFailWithError:(NSError *)error {
    if (error.code != 102 && error.code != 101) {
        self.authViewController = nil;
        self.sessionCompletion(nil, error);
    }
}

- (void)authViewControllerDidCancel:(InstagramAuthViewController *)viewController {
    self.authViewController = nil;
    self.sessionCompletion(nil, [NSError errorWithDomain:@"com.Hot-Spot.app"
                                                    code:0
                                                userInfo:@{ NSLocalizedDescriptionKey : @"Authentication canceled by user." }]);
}

@end