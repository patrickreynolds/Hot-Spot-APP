//
//  InstagramMedia.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/9/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "InstagramMedia.h"
#import "DataFetcher.h"
#import "InstagramAPIKey.h"
#import "MediaCaption.h"

@implementation InstagramMedia
@synthesize mediaData;

#define ALL_LIKES_QUERY @"https://api.instagram.com/v1/media/%@/likes?access_token=%@"
#define ALL_COMMENTS_QUERY @"https://api.instagram.com/v1/media/%@/comments?access_token=%@"

- (InstagramMedia *)initMedia:(NSMutableDictionary *)withMediaData
{
    self = [super init];
    
    // Initializing with media data
    self.mediaData = withMediaData;
    
    return self;
}

- (NSArray *)tags
{
    return [self.mediaData objectForKey:@"tags"];
}

- (NSString *)type
{
    return [self.mediaData objectForKey:@"type"];
}

- (NSString *)latitude
{
    if (![[self.mediaData objectForKey:@"location"] isKindOfClass:[NSNull class]] && ![[[self.mediaData objectForKey:@"location"] objectForKey:@"latitude"] isKindOfClass:[NSNull class]]) {
        return [[self.mediaData objectForKey:@"location"] objectForKey:@"latitude"];
    } else {
        return nil;
    }
}

- (NSString *)longitude
{
    if (![[self.mediaData objectForKey:@"location"] isKindOfClass:[NSNull class]] && ![[[self.mediaData objectForKey:@"location"] objectForKey:@"longitude"] isKindOfClass:[NSNull class]]) {
        return [[self.mediaData objectForKey:@"location"] objectForKey:@"longitude"];
    } else {
        return nil;
    }
}

- (MediaComments *)comments
{
    if (![[self.mediaData objectForKey:@"comments"] isKindOfClass:[NSNull class]]) {
        return [[MediaComments alloc] initMediaComments:[self.mediaData objectForKey:@"comments"]];
    } else {
        return nil;
    }
}

- (NSString *)filter
{
    return [self.mediaData objectForKey:@"filter"];
}

- (NSDate *)created_time
{
    return [NSDate dateWithTimeIntervalSince1970:[[self.mediaData objectForKey:@"created_time"] doubleValue]];
}

- (NSURL *)link
{
    NSURL* url = [[NSURL alloc] initWithString:[self.mediaData objectForKey:@"link"]];
    return url;
}

- (MediaLikes *)likes
{
    MediaLikes* currentLikes = [[MediaLikes alloc] initMediaLikes:[self.mediaData objectForKey:@"likes"]];
    //return [[self.mediaData objectForKey:@"likes"] objectForKey:@"data"];
    return currentLikes;
}

- (NSURL *)thumbnail_url
{
    NSURL* url = [[NSURL alloc] initWithString:[[[self.mediaData objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"]];
    return url;
}

- (NSURL *)low_resolution_url
{
    NSURL* url = [[NSURL alloc] initWithString:[[[self.mediaData objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"]];
    return url;
}

- (NSURL *)standard_resolution_url
{
    NSURL* url = [[NSURL alloc] initWithString:[[[self.mediaData objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"]];
    return url;
}

- (NSMutableArray *)users_in_photo
{
    return [self.mediaData objectForKey:@"users_in_photo"];
}

- (MediaCaption *)caption
{
    if (![[self.mediaData objectForKey:@"caption"] isKindOfClass:[NSNull class]]) {
        MediaCaption *caption = [[MediaCaption alloc] initCaption:[self.mediaData objectForKey:@"caption"]];
        return caption;
    } else {
        return nil;
    }
}

- (NSString *)user_has_liked
{
    return [self.mediaData objectForKey:@"user_has_liked"];
}

- (NSString *)media_id
{
    return [self.mediaData objectForKey:@"id"];
}

- (InstagramUser *)owner
{
    InstagramUser* photoUser = [[InstagramUser alloc] initInstagramUser:[self.mediaData objectForKey:@"user"]];
    return photoUser;
}


// Returns an array of InstagramUser objects who have likes this piece of media.
// Media is taken from self.media_id
- (NSArray *)allLikes
{
    NSString* likesQuery = [[NSString alloc] initWithFormat:ALL_LIKES_QUERY, [self media_id], InstagramAPIKey];
    
    NSLog(@"*** Requesting Media \"Likes\" Data ***");
    NSDate *beforeRequest = [NSDate date];
    NSMutableArray* dataLikes = [DataFetcher sendInstagramAPIRequest:likesQuery]; // Using DataFetcher to do the Instagram API request
    NSDate *afterRequest = [NSDate date];
    
    // Determining how long it took to retrieve all data from instagram
    double responseTimeForAllRequests = [afterRequest timeIntervalSinceDate:beforeRequest];
    NSLog(@"Response time to retrieve all likes via Instagram API: %f.", responseTimeForAllRequests);

    //MediaLikes* newLikes = [[MediaLikes alloc] init];
    NSNumber *count = [NSNumber numberWithDouble:[dataLikes count]];

    NSMutableArray *allLikes = [[NSMutableArray alloc] init];
    if (count == 0) { // Checking incase this media didn't have any comments
        return nil;
    } else {
        for (NSUInteger i = 0; i < [dataLikes count]; i++) {
            
            // Making an Instagram User object to represent a user who has liked this piece of media.
            InstagramUser* newUser = [[InstagramUser alloc] initInstagramUser:[dataLikes objectAtIndex:i]];
            
            // Adding that user object to the allLikes list
            [allLikes addObject:newUser];
        }
    }
    
    // Returning an array of InstagramUsers.
    return (NSArray *)allLikes;
}


// Returns an array of InstagramUser objects who have commented on this piece of media.
// Media is taken from self.media_id
- (NSArray *)allComments
{
    // Initializing all comments array before response
    NSMutableArray *allComments = [[NSMutableArray alloc] init];
    
    // API query string that uses self.media_id and global InstagramAPIKey
    NSString* likesQuery = [[NSString alloc] initWithFormat:ALL_COMMENTS_QUERY, [self media_id], InstagramAPIKey];
    
        NSLog(@"*** Requesting Media \"Comments\" Data ***");
    NSDate *beforeRequest = [NSDate date];
    NSMutableArray *dataComments = [DataFetcher sendInstagramAPIRequest:likesQuery];
    NSDate *afterRequest = [NSDate date];
    
    // Determining how long it took to retrieve all data from instagram
    double responseTimeForAllRequests = [afterRequest timeIntervalSinceDate:beforeRequest];
    NSLog(@"Response time to retrieve all comments via Instagram API: %f.", responseTimeForAllRequests);
    
    // Number of users who have commented on this media.
    NSNumber *count = [NSNumber numberWithDouble:[dataComments count]];
    
    if (count == 0) { // Checking in case this media did not have any comments
        return nil;
    } else {
        for (NSUInteger i = 0; i < [dataComments count]; i++) {
            MediaCaption* newCaption = [[MediaCaption alloc] initCaption:[dataComments objectAtIndex:i]];
            [allComments addObject:newCaption];
        }
    }
    
    // Returning an array of MediaCaptions; which contain data from the user
    // that left the comment, along with the comment text.
    return (NSArray *)allComments;
}



@end

