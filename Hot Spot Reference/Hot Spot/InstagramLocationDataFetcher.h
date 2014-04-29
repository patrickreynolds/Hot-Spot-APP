//
//  InstagramLocationDataFetcher.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 1/21/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstagramLocaiton.h"

@interface InstagramLocationDataFetcher : NSObject

@property (strong, nonatomic) NSString *access_token;

// Takes a string initializing InstagramLocationDataFetcher with an Instagram access_token
- (instancetype)initDataFetcher :(NSString *)withAccessToken;

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
- (InstagramLocaiton *)getInstagramLocationDataWithAttributes: (NSString *)name :(NSString *)latitude :(NSString *)longitude;


// Takes an InstagramLocation and returns another instagram location instance. Typically used
// to retrieve more data from a locaition.
// For example, if an instagarmlocation is passed with a maxTimeStamp, the new InstagramLocation
// instance will return with the appended new InstagramMedia to instagramLocaiton.locationPhotos array.
- (InstagramLocaiton *)getPhotosForLocation:(InstagramLocaiton *)instagramLocation;

@end
