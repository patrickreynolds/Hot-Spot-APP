//
//  InstagramLocaiton.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 1/21/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "InstagramLocaiton.h"

@implementation InstagramLocaiton

- (NSMutableArray *)locationPhotos
{
    if (!_locationPhotos) _locationPhotos = [[NSMutableArray alloc] init];
    return _locationPhotos;
}

- (instancetype)initLocaitonWith:(NSString *)name :(NSString *)maxTimeStamp :(NSString *)minTimeStamp :(NSString *)latitude :(NSString *)longitude :(NSMutableArray *)locationPhotos
{
    self = [super init];
    
    self.name = name;
    self.maxTimeStamp = maxTimeStamp;
    self.minTimeStamp = minTimeStamp;
    self.latitude = latitude;
    self.longitude = longitude;
    self.locationPhotos = locationPhotos;
    
    return self;
}

- (NSString *)maxTimeStamp
{
    if (!_maxTimeStamp) {
        return @"0";
    }
    return _maxTimeStamp;
}

- (NSString *)minTimeStamp
{
    if (!_minTimeStamp) {
        return @"0";
    }
    return _minTimeStamp;
}

@end
