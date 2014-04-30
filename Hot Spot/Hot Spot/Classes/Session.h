//
//  Session.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

+ (NSString *)sessionToken;
+ (NSString *)userId;
+ (void)storeSessionToken:(NSString *)sessionToken andUserId:(NSString *)userId;
+ (void)destroySession;

@end
