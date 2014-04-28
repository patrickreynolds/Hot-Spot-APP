//
//  InstagramLocationDataFetcher.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 1/21/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "InstagramLocationDataFetcher.h"
#import "InstagramMedia.h"
#import "InstagramLocaiton.h"

@implementation InstagramLocationDataFetcher

// Takes a string initializing InstagramLocationDataFetcher with an Instagram access_token
- (instancetype)initDataFetcher :(NSString *)withAccessToken
{
    self = [super init];
    
    self.access_token = withAccessToken;
    
    return self;
}

- (InstagramLocaiton *)getInstagramLocationDataWithAttributes: (NSString *)name :(NSString *)latitude :(NSString *)longitude
{
    InstagramLocaiton *newLocation = [[InstagramLocaiton alloc] init];
    
    newLocation.name = name;
    newLocation.latitude = latitude;
    newLocation.longitude = longitude;
    
    newLocation = [self getPhotosForLocation:newLocation];
    
    return newLocation;
}

- (InstagramLocaiton *)getPhotosForLocation:(InstagramLocaiton *)instagramLocation
{
    NSString *radius = @"200";
    NSString* appendLatitude = [@"lat=" stringByAppendingString:instagramLocation.latitude];
    NSString* appendLongitude = [@"&lng=" stringByAppendingString:instagramLocation.longitude];
    NSString* appendMaxTimestamp = [@"&max_timestamp=" stringByAppendingString:instagramLocation.maxTimeStamp];
    NSString* appendMinTimestamp = [@"&min_timestamp=" stringByAppendingString:instagramLocation.minTimeStamp];
    NSString* appendRadius = [@"&distance=" stringByAppendingString:radius];
    NSString* query = [[@"https://api.instagram.com/v1/media/search?" stringByAppendingString:appendLatitude] stringByAppendingString:appendLongitude];
    
    if (![instagramLocation.maxTimeStamp isEqualToString:@"0"]) {
        query = [query stringByAppendingString:appendMaxTimestamp];
    }
    /*
    if (![instagramLocation.minTimeStamp isEqualToString:@"0"]) {
        query = [query stringByAppendingString:appendMinTimestamp];
    }
    */
    if (radius) {
        query = [query stringByAppendingString:appendRadius];
    }
    
    query = [[query stringByAppendingString:@"&access_token="] stringByAppendingString:self.access_token];
    
    NSLog(@"Location Query: %@", query);
    
    NSData* locationData = [NSData dataWithContentsOfURL:[NSURL URLWithString:query]];
    NSError* error = nil;
    NSMutableDictionary* locationResponseData = [NSJSONSerialization JSONObjectWithData:locationData options:kNilOptions error:&error];
    NSMutableArray* locationPhotosList = (NSMutableArray *)[locationResponseData objectForKey:@"data"];
    
    for(NSDictionary *photo in locationPhotosList) {
        InstagramMedia *newMedia = [[InstagramMedia alloc] initMedia:(NSMutableDictionary *)photo];
        [instagramLocation.locationPhotos addObject:newMedia];
    }
    
    instagramLocation.minTimeStamp = [NSString stringWithFormat:@"%f", [[[locationPhotosList firstObject] objectForKey:@"created_time"] doubleValue]];
    instagramLocation.maxTimeStamp = [NSString stringWithFormat:@"%f", [[[locationPhotosList lastObject] objectForKey:@"created_time"] doubleValue] - 50];
    
    return instagramLocation;
}

@end
