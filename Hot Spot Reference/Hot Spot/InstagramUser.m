//
//  InstagramUser.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/9/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "InstagramUser.h"
#import "InstaFetcher.h"
#import "InstagramUserDataFetcher.h"
#import "InstagramImage.h"
#import "MediaCaption.h"

@interface InstagramUser()

@end

@implementation InstagramUser

- (InstagramUser *)initInstagramUser:(NSMutableDictionary *)withUserData
{
    self = [super init];
    
    // Initializing user with json data
    self.userData = withUserData;
     
    return self;
}

- (NSString *)username
{
    return [self.userData objectForKey:@"username"];
}

- (NSString *)bio
{
    if (![[self.userData objectForKey:@"bio"] isKindOfClass:[NSNull class]]) {
        return [self.userData objectForKey:@"bio"];
    } else {
        return nil;
    }
}

- (NSString *)website{
    if (![[self.userData objectForKey:@"website"] isKindOfClass:[NSNull class]]) {
        return [self.userData objectForKey:@"website"];
    } else {
        return nil;
    }
}

- (NSURL *)profile_picture
{
    NSURL *url = [NSURL URLWithString:[self.userData objectForKey:@"profile_picture"]];
    return url;
}

- (NSString *)full_name
{
    if (![[self.userData objectForKey:@"full_name"] isKindOfClass:[NSNull class]]) {
        return [self.userData objectForKey:@"full_name"];
    } else {
        return nil;
    }
}

- (NSString *)user_id
{
    return [self.userData objectForKey:@"id"];
}


// These methods should be owned by InstagramUserDataFetcher, but leaving in temporarally in the meantime.
- (NSNumber *)media
{
    InstagramUserDataFetcher *dataFetcher = [[InstagramUserDataFetcher alloc] initDataFetcher:[InstaFetcher getAccessToken]];
    return [dataFetcher mediaCount:[self username] :[self user_id]];
}

- (NSArray *)follows
{
    InstagramUserDataFetcher *dataFetcher = [[InstagramUserDataFetcher alloc] initDataFetcher:[InstaFetcher getAccessToken]];
    return [dataFetcher follows:[self username] :[self user_id]];
}

- (NSArray *)followed_by
{
    InstagramUserDataFetcher *dataFetcher = [[InstagramUserDataFetcher alloc] initDataFetcher:[InstaFetcher getAccessToken]];
    return [dataFetcher follows:[self username] :[self user_id]];
}
// Remove and abstract out to InstagramUserDataFetcher

@end
