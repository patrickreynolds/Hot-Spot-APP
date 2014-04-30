//
//  Session.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "Session.h"

@implementation Session

static NSString *kSessionTokenKey = @"session_token";
static NSString *kUserIdKey = @"user_id";

+ (NSString *)sessionToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    return [defaults objectForKey:kSessionTokenKey];
}

+ (NSString *)userId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    return [defaults objectForKey:kUserIdKey];
}

+ (void)storeSessionToken:(NSString *)sessionToken andUserId:(NSString *)userId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:sessionToken forKey:kSessionTokenKey];
    [defaults setObject:userId forKey:kUserIdKey];
    [defaults synchronize];
}

+ (void)destroySession {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults removeObjectForKey:kSessionTokenKey];
    [defaults removeObjectForKey:kUserIdKey];
    [defaults synchronize];
}

@end
