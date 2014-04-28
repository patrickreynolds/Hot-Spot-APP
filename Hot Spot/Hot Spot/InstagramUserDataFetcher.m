//
//  InstagramUserDataFetcher.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 1/7/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "InstaFetcher.h"
#import "InstagramUserDataFetcher.h"
#import "DataFetcher.h"
#import "InstagramMedia.h"

@interface InstagramUserDataFetcher ()

// Private, local access_token that is set in initDataFetcher.
@property (strong, nonatomic) NSString* access_token;

@end

@implementation InstagramUserDataFetcher

// Relationship API Querys
#define QUERY_USER_INFO_BY_USER_ID @"https://api.instagram.com/v1/users/%@&access_token=%@"
#define QUERY_FOLLOWS_BY_USER_ID @"https://api.instagram.com/v1/users/%@/follows?access_token=%@"
#define QUERY_FOLLOWED_BY_USER_ID @"https://api.instagram.com/v1/users/%@/followed-by?access_token=%@"

// User API QUerys
#define QUERY_MEDIA_RECENT @"https://api.instagram.com/v1/users/%@/media/recent?access_token=%@"
#define QUERY_USER_ID_BY_USERNAME @"https://api.instagram.com/v1/users/search?q=%@&access_token=%@"

- (InstagramUserDataFetcher *)initDataFetcher:(NSString *)withAccessToken
{
    self = [super init];
    
    // Initializing access_token
    self.access_token = withAccessToken;

    return self;
}

// Takes an Instagram username and returns the user's internal Instagram ID.
// This ID is used for additional API calls.
- (NSString *)getUserIdForUsername :(NSString *)username
{
    NSString* getUserIdQuery = [NSString stringWithFormat:QUERY_USER_ID_BY_USERNAME, username, self.access_token];
        NSLog(@"Get userId query: %@", getUserIdQuery);
    NSMutableArray *requestResponseArray = [DataFetcher sendInstagramAPIRequestForDataObject:getUserIdQuery];
    
    NSString* userID = [[NSString alloc] init];

    // Parse primary data object from response
    if ([requestResponseArray count] > 0) {
        
        userID = [requestResponseArray[0] objectForKey:@"id"]; // Parse id from user object
        
    } else { // username did not exist. Assigning response to null
        userID = nil;
    }
    
    return userID;
}


// Takes an Instagram username and returns an array of InstagramMedia objects
- (NSArray *)getPhotoListForUsername :(NSString *)username
{
    NSMutableArray* photoList = [[NSMutableArray alloc] init];
    
    NSString* user_id = [self getUserIdForUsername:username];
    NSString* query = [NSString stringWithFormat:QUERY_MEDIA_RECENT, user_id, self.access_token];
    NSLog(@"Media recent query: %@", query);
    
    NSMutableArray* photoListData = [DataFetcher sendInstagramAPIRequest:query];
    
    for (NSMutableDictionary *photoData in photoListData) {
        InstagramMedia* newMedia = [[InstagramMedia alloc] initMedia:photoData];
        [photoList addObject:newMedia];
    }
    
    NSLog(@"*** Photolist count: %lu ***", [photoList count]);
    return (NSArray *)photoList;
}


// Takes an Instagram username and returns a Dictionary modeling a complete
// list of all users who have liked the passed usernames content paired with cumulative counts.
// Dictionary Key -> Instagram Username
// Dictionary Value -> Cumulative count of media that user has liked.
- (NSDictionary *)getPopularLikesForUsername:(NSString *)username
{
    NSMutableDictionary *popularLikesList = [[NSMutableDictionary alloc] init];
    NSArray *userMedia = [self getPhotoListForUsername:username];

    int count = (int)[userMedia count];

    for (InstagramMedia *media in userMedia) {
        NSLog(@"\n\n-- New Photo: Number #%d --\n", count);
        NSArray *allUsersWhoLikeThisPhoto = [media allLikes];
        
        if ([allUsersWhoLikeThisPhoto count] > 0) {
            for(InstagramUser* user in allUsersWhoLikeThisPhoto){
                NSLog(@"Like from: %@ - %@",user.username, user.full_name);
                if ([popularLikesList objectForKey:user.username]) {
                    NSNumber* currentLikeCount = [popularLikesList objectForKey:user.username];
                    currentLikeCount = @([currentLikeCount integerValue] + 1);
                    [popularLikesList setObject:currentLikeCount forKey:user.username];
                }else {
                    [popularLikesList setObject:[NSNumber numberWithInt:1] forKey:user.username];
                }
            }
        }
        count--;
    }
    
    return (NSDictionary *)popularLikesList;
}


// Takes an Instagram username and returns a Dictionary modeling a complete
// list of all users who have commented on the passed username's content, paired with cumulative counts.
// Dictionary Key -> Instagram Username
// Dictionary Value -> Cumulative count of media that user has commented on.
- (NSDictionary *)getPopularCommentsForUsername:(NSString *)username
{
    NSMutableDictionary* popularCommentsList = [[NSMutableDictionary alloc] init];
    NSArray *userMedia = [self getPhotoListForUsername:username];
    
    int count = (int)[userMedia count];
    
    for(InstagramMedia *media in userMedia){
        NSLog(@"\n\n-- New Photo: Number #%d --\n", count);
        NSArray *allCaptionsOnUsersPhotos = [media allComments];

        if ([allCaptionsOnUsersPhotos count] > 0) {
            for (MediaCaption *caption in allCaptionsOnUsersPhotos) {
                NSLog(@"Comment from: %@ - %@", caption.from_username, caption.from_full_name);
                if ([popularCommentsList objectForKey:caption.from_username]) {
                    NSNumber *currentCommentCount = [popularCommentsList objectForKey:caption.from_username];
                    currentCommentCount = @([currentCommentCount integerValue] + 1);
                    [popularCommentsList setObject:currentCommentCount forKey:caption.from_username];
                } else {
                    [popularCommentsList setObject:[NSNumber numberWithInt:1] forKey:caption.from_username];
                }
            }
        }
        count--;
    }
        
    return (NSDictionary *)popularCommentsList;
}


// Takes an Instagram username and returns an NSNumber object of the current
// number of media (images + video) the user has posted.
- (NSNumber *)mediaCount:(NSString *)username :(NSString *)withOptionalUserID
{
    NSString *userID = withOptionalUserID;
    
    if (!userID) {
        userID = [InstaFetcher getUserIdForUsername:username];
    }
    NSString *mediaCountQuery = [[NSString alloc] initWithFormat:QUERY_USER_INFO_BY_USER_ID, userID, self.access_token];
    
    NSData *queryData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mediaCountQuery]];
    NSError *error = nil;
    NSMutableDictionary *requestResponse = [NSJSONSerialization JSONObjectWithData:queryData options:kNilOptions error:&error];
    NSNumber *mediaCount = [NSNumber numberWithInteger:[[[requestResponse objectForKey:@"counts"] objectForKey:@"media"] integerValue]];
    return mediaCount;
}


// Takes two parameters: an Instagram username and the userID for that user if available.
// If the internal Instagram userID is now known, follows will retrieve the
// userID by doing an additional API request, getUserIdForUsername:username.
// Returns an array of Instagram username strings that the passed username follows.
- (NSArray *)follows:(NSString *)username :(NSString *)withOptionalUserID
{
    NSString *userID = withOptionalUserID;
    
    if (!userID) {
        userID = [InstaFetcher getUserIdForUsername:username];
    }
    
    NSString *followsQueryString = [[NSString alloc] initWithFormat:QUERY_FOLLOWS_BY_USER_ID, userID, self.access_token];
    NSDate *startQueryTime = [NSDate date];
    NSMutableArray *userFollows = [DataFetcher sendInstagramAPIRequest:followsQueryString];
    NSDate *endQUeryTime = [NSDate date];
    double queryResponseTime = [endQUeryTime timeIntervalSinceDate:startQueryTime];
    NSLog(@"Response time to retrieve list of all users %@ follows: %f.", username, queryResponseTime);
    
    NSMutableArray *follows = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *userData in userFollows) {
        InstagramUser *user = [[InstagramUser alloc] initInstagramUser:userData];
        [follows addObject:user.username];
    }
    
    return (NSArray *)follows;
}


// Takes two parameters: an Instagram username and the userID for that user if available.
// If the internal Instagram userID is now known, follows will retrieve the
// userID by doing an additional API request, getUserIdForUsername:username.
// Returns an array of Instagram username strings of users that follow the passed username.
- (NSArray *)followed_by:(NSString *)username :(NSString *)withOptionalUserID
{
    NSString *userID = withOptionalUserID;
    
    if (!userID) {
        userID = [InstaFetcher getUserIdForUsername:username];
    }
    
    NSString *followed_byQueryString = [[NSString alloc] initWithFormat:QUERY_FOLLOWED_BY_USER_ID, userID, self.access_token];

    NSDate *startQuery = [NSDate date];
    NSMutableArray *userIsFollowed_by = [DataFetcher sendInstagramAPIRequest:followed_byQueryString];
    NSDate *endQuery = [NSDate date];
    
    double queryResponseTime = [endQuery timeIntervalSinceDate:startQuery];
    NSLog(@"Response time to retrieve list of all users who follow %@: %f.",username, queryResponseTime);
    
    NSMutableArray *followed_by = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *userData in userIsFollowed_by) {
        InstagramUser *user = [[InstagramUser alloc] initInstagramUser:userData];
        [followed_by addObject:user.username];
    }
    
    return (NSArray *)followed_by;
}


// Takes an Instagram username and returns a list of users that the passed
// username follows, who don't follow them back.
- (NSArray *)whoDoesntFollowUserBack:(NSString *)username :(NSString *)withOptionalUserID
{
    NSString *userID = withOptionalUserID;
    
    if (!userID) {
        userID = [InstaFetcher getUserIdForUsername:username];
    }
    
    NSMutableArray *whoDoesntFollowUserBack = [[NSMutableArray alloc] init];
    NSArray *followsList = [self follows:username :userID];
    NSArray *followed_by = [self followed_by:username :userID];
    
    for (NSString *username in followsList) {
        if (![followed_by containsObject:username]) {
            [whoDoesntFollowUserBack addObject:username];
        }
    }
    
    return (NSArray *)whoDoesntFollowUserBack;
}


// Takes an Instagram username and returns a list of userns who follow the past
// username that the passed username does not follow back. Mah bad.
- (NSArray *)whoDoesntUserFollowBack :(NSString *)username :(NSString *)withOptionalUserID
{
    NSString *userID = withOptionalUserID;
    
    if (!userID) {
        userID = [InstaFetcher getUserIdForUsername:username];
    }
    
    NSMutableArray *whoDoesntUserFollowBack = [[NSMutableArray alloc] init];
    NSArray *followsList = [self follows:username :userID];
    NSArray *followed_by = [self followed_by:username :userID];
    
    for (NSString *username in followed_by) {
        if (![followsList containsObject:username]) {
            [whoDoesntUserFollowBack addObject:username];
        }
    }
    
    return (NSArray *)whoDoesntUserFollowBack;
}

    
@end
