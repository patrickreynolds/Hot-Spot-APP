//
//  InstagramUserDataFetcher.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 1/7/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramUserDataFetcher : NSObject

// Takes a string initializing InstagramUserDataFetcher with an Instagram access_token
- (InstagramUserDataFetcher *)initDataFetcher :(NSString *)withAccessToken;


// Takes an Instagram username and returns the user's internal Instagram ID.
// This ID is used for additional API calls.
- (NSString *)getUserIdForUsername :(NSString *)username;


// Takes an Instagram username and returns an array of InstagramMedia objects
- (NSArray *)getPhotoListForUsername :(NSString *)username;


// Takes an Instagram username and returns a Dictionary modeling a complete
// list of all users who have liked the passed usernames content paired with cumulative counts.
// Dictionary Key -> Instagram Username
// Dictionary Value -> Cumulative count of media that user has liked.
- (NSDictionary *)getPopularLikesForUsername:(NSString *)username;


// Takes an Instagram username and returns a Dictionary modeling a complete
// list of all users who have commented on the passed username's content, paired with cumulative counts.
// Dictionary Key -> Instagram Username
// Dictionary Value -> Cumulative count of media that user has commented on.
- (NSDictionary *)getPopularCommentsForUsername:(NSString *)username;


// Takes an Instagram username and returns an NSNumber object of the current
// number of media (images + video) the user has posted.
- (NSNumber *)mediaCount:(NSString *)username :(NSString *)withOptionalUserID;


// Takes two parameters: an Instagram username and the userID for that user if available.
// If the internal Instagram userID is now known, follows will retrieve the
// userID by doing an additional API request, getUserIdForUsername:username.
// Returns an array of Instagram username strings that the passed username follows.
- (NSArray *)follows:(NSString *)username :(NSString *)withOptionalUserID;


// Takes two parameters: an Instagram username and the userID for that user if available.
// If the internal Instagram userID is now known, follows will retrieve the
// userID by doing an additional API request, getUserIdForUsername:username.
// Returns an array of Instagram username strings of users that follow the passed username.
- (NSArray *)followed_by:(NSString *)username :(NSString *)withOptionalUserID;


// Takes an Instagram username and returns a list of users that the passed
// username follows, who don't follow them back.
- (NSArray *)whoDoesntUserFollowBack :(NSString *)username :(NSString *)withOptionalUserID;


// Takes an Instagram username and returns a list of userns who follow the past
// username that the passed username does not follow back. Mah bad.
- (NSArray *)whoDoesntFollowUserBack :(NSString *)username :(NSString *)withOptionalUserID;
@end
