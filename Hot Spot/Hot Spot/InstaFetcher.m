//
//  InstaFetcher.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/9/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "InstaFetcher.h"
#import "InstagramAPIKey.h"
#import "InstagramUserDataFetcher.h"
#import "InstagramUser.h"
#import "InstagramLocationDataFetcher.h"
#import "InstagramLocaiton.h"

@interface InstaFetcher ()

@property (strong, nonatomic) NSString* access_token;

@end

@implementation InstaFetcher
@synthesize access_token;

// Temporary access_token class method for passing along Instagram access_token
+ (NSString *)getAccessToken
{
    return InstagramAPIKey;
}

// Takes a string that initializes InstaFetcher with Instagram access_token
- (id)init :(NSString *)withAccessToken
{
    self = [super init];
    
    // Set access token
    self.access_token = withAccessToken;
    
    return self;
}

// Takes an Instagram username and returns the user's internal Instagram ID.
// This ID is used for additional API calls.
+ (NSString *)getUserIdForUsername :(NSString *)username
{
    InstagramUserDataFetcher *dataFetcher = [[InstagramUserDataFetcher alloc] initDataFetcher:InstagramAPIKey];
    return [dataFetcher getUserIdForUsername:username];
}

// Takes an Instagram username and returns an array of InstagramMedia objects
+ (NSArray *)getUserPhotosForUsername :(NSString *)username
{
    InstagramUserDataFetcher *dataFetcher = [[InstagramUserDataFetcher alloc] initDataFetcher:InstagramAPIKey];
    return [dataFetcher getPhotoListForUsername:username];
}

// Takes an Instagram username and returns a list of users that the passed
// username follows, who don't follow them back. C'mon man?!
+ (NSArray *)listOfUsersUsernameFollowsWhoDoNotFollowUsernameBack :(NSString *)username
{
    InstagramUserDataFetcher *dataFetcher = [[InstagramUserDataFetcher alloc] initDataFetcher:InstagramAPIKey];
    return [dataFetcher whoDoesntFollowUserBack :username :nil];
}

// Takes an Instagram username and returns a list of userns who follow the past
// username that the passed username does not follow back. Mah bad.
+ (NSArray *)listOfUsersWhoFollowUsernameThatUsernameDoesNotFollowBack :(NSString *)username
{
    InstagramUserDataFetcher *dataFetcher = [[InstagramUserDataFetcher alloc] initDataFetcher:InstagramAPIKey];
    return [dataFetcher whoDoesntUserFollowBack :username :nil];
}

// Takes an Instagram username and returns a Dictionary modeling a complete
// list of all users who have liked the passed usernames content paired with cumulative counts.
// Dictionary Key -> Instagram Username
// Dictionary Value -> Cumulative count of media that user has liked.
+ (NSDictionary *)topLikes:(NSString *)username
{
    InstagramUserDataFetcher *dataFetcher = [[InstagramUserDataFetcher alloc] initDataFetcher:InstagramAPIKey];
    return [dataFetcher getPopularLikesForUsername:username];
}


// Takes an Instagram username and returns a Dictionary modeling a complete
// list of all users who have commented on the passed username's content, paired with cumulative counts.
// Dictionary Key -> Instagram Username
// Dictionary Value -> Cumulative count of media that user has commented on.
+ (NSDictionary *)topComments:(NSString *)username
{
    InstagramUserDataFetcher *dataFetcher = [[InstagramUserDataFetcher alloc] initDataFetcher:InstagramAPIKey];
    return [dataFetcher getPopularCommentsForUsername:username];
}


// Takes in a Dictionary and prints a sorted dictionary by object
+ (void)printSortedDictionary:(NSDictionary *)unsortedDictionary
{
     NSArray* sortedArray = [unsortedDictionary keysSortedByValueUsingComparator:^(id first, id second) {
     if ([first integerValue] > [second integerValue])
         return (NSComparisonResult)NSOrderedDescending;
     
         if ([first integerValue] < [second integerValue])
             return (NSComparisonResult)NSOrderedAscending;
         
         return (NSComparisonResult)NSOrderedSame;
     }];
    NSLog(@"Sorted Array Count: %lu", [sortedArray count]);
     for (NSInteger i = [sortedArray count] - 1; i > -1; i--) {
         NSLog(@"%@ - %@", [sortedArray objectAtIndex:i], [unsortedDictionary objectForKey:[sortedArray objectAtIndex:i]]);
     }
}

// Takes the name, latitude, and longitude of a location and returns an InstagramLocation.
// An InstagramLocation consists of 5 attributes that can be used to display the information
// or retrieve more information.
// These attributes include:
// instagramLocationInstance.name // The name of the location
// instagramLocationInstance.maxTimeStamp // The timestamp of the last photo in the locationPhotos array
// instagramLocationInstance.minTimeStamp // The timestamp of the first photo in the locationPhhtos array
// instagramLocationInstance.latitude // The latitude of the locaiton
// instagramLocationInstance.longitude // The longigude of the location
// instagramLocationInstance.locationPhotos // An array of InstagramMedia that were taken at this location within the given timeframe
+ (InstagramLocaiton *)getLocationInfoForLocationName:(NSString *)name withLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
    InstagramLocationDataFetcher *locationDataFetcher = [[InstagramLocationDataFetcher alloc] initDataFetcher:InstagramAPIKey];
    InstagramLocaiton *location = [[InstagramLocaiton alloc] init];
    location = [locationDataFetcher getInstagramLocationDataWithAttributes:name :latitude :longitude];
    return location;
}


// Takes an InstagramLocation and returns another instagram location instance. Typically used
// to retrieve more data from a locaition.
// For example, if an instagarmlocation is passed with a maxTimeStamp, the new InstagramLocation
// instance will return with the appended new InstagramMedia to instagramLocaiton.locationPhotos array.
+ (InstagramLocaiton *)getMoreLocationInfoFromLocation: (InstagramLocaiton *)location
{
    InstagramLocationDataFetcher *locationDataFetcher = [[InstagramLocationDataFetcher alloc] initDataFetcher:InstagramAPIKey];
    location = [locationDataFetcher getPhotosForLocation:location];
    return location;
}


@end
