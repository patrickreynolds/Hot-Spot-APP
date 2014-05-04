//
//  InstagramPlatform.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 03/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, InstagramPlatformAuthScope) {
    InstagramPlatformAuthScopeBasic         = 1 << 0,
    InstagramPlatformAuthScopeComments      = 1 << 1,
    InstagramPlatformAuthScopeRelationships = 1 << 2,
    InstagramPlatformAuthScopeLikes         = 1 << 3,
    InstagramPlatformAuthScopeAll           = 1 << 4
};

typedef void(^InstagramPlatformSessionCompletion)(NSString *accessToken, NSError *error);

@interface InstagramPlatform : NSObject

@property (nonatomic, readonly) NSString *redirectURI;

+ (InstagramPlatform *)sharedPlatform;
+ (NSString *)basePlatformURL;
+ (NSString *)currentPlatformVersion;

- (void)startSessionWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret completion:(InstagramPlatformSessionCompletion)completion;
- (void)startSessionWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret authScope:(InstagramPlatformAuthScope)authScope completion:(InstagramPlatformSessionCompletion)completion;
- (void)startSessionWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret authScope:(InstagramPlatformAuthScope)authScope redirectURI:(NSString *)redirectURI completion:(InstagramPlatformSessionCompletion)completion;

@end
