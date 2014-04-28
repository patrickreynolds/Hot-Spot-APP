//
//  LocationPhotos.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/13/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "LocationPhotos.h"
#import "InstagramMedia.h"

@implementation LocationPhotos

-(LocationPhotos *)initLocationPhotos :(NSMutableArray *)withLocationData
{
    LocationPhotos* locationPhotosInstance = [[LocationPhotos alloc] init];
    NSMutableArray* tempLocationPhotos = [[NSMutableArray alloc] init];

    for (NSUInteger i = 0; i < [withLocationData count]; i++) {
        InstagramMedia* newPhoto = [[InstagramMedia alloc] initMedia:[withLocationData objectAtIndex:i]];
        [tempLocationPhotos addObject:newPhoto];
    }
    
    locationPhotosInstance.photoCount = [NSString stringWithFormat:@"%lu", (unsigned long)tempLocationPhotos.count];

    if ([tempLocationPhotos count] != 0) {
        InstagramMedia* minTime = [tempLocationPhotos objectAtIndex:0];
        locationPhotosInstance.minTime = minTime.created_time;
        InstagramMedia* maxTime = [tempLocationPhotos objectAtIndex:(tempLocationPhotos.count - 1)];
        locationPhotosInstance.maxTime = maxTime.created_time;
    } else {
        locationPhotosInstance.minTime = @"";
        locationPhotosInstance.maxTime = @"";
    }

    locationPhotosInstance.locationPhotosList = tempLocationPhotos;

    return locationPhotosInstance;
}

@end
