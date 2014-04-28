//
//  InstagramUser.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/9/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramUser : NSObject

@property (strong, nonatomic) NSMutableDictionary *userData;

@property (strong, nonatomic, readonly) NSString* username;
@property (strong, nonatomic, readonly) NSString* bio;
@property (strong, nonatomic, readonly) NSString* website;
@property (strong, nonatomic, readonly) NSURL* profile_picture;
@property (strong, nonatomic, readonly) NSString* full_name;
@property (strong, nonatomic, readonly) NSString* user_id;

// Following getters perform additional API requests
// Planning to abstract out completly to InstagramUserDataFetcher in the future.
@property (strong, nonatomic, readonly) NSNumber* media;
@property (strong, nonatomic, readonly) NSArray* followed_by;
@property (strong, nonatomic, readonly) NSArray* follows;

- (InstagramUser *)initInstagramUser :(NSMutableDictionary *)withUserData;

@end
