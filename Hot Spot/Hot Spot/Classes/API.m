//
//  API.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "API.h"

@implementation API

+ (NSString *)signupUrl {
    static NSString *signupUrl = nil;
    if (signupUrl == nil) {
        signupUrl = [NSString stringWithFormat:@"%@%@", API_URL, @"user/signup"];
    }
    return signupUrl;
}

+ (NSString *)loginUrl {
    static NSString *loginUrl = nil;
    if (loginUrl == nil) {
        loginUrl = [NSString stringWithFormat:@"%@%@", API_URL, @"user/login"];
    }
    return loginUrl;
}

+ (NSString *)associateUrl {
    static NSString *associateUrl = nil;
    if (associateUrl == nil) {
        associateUrl = [NSString stringWithFormat:@"%@%@", API_URL, @"user/associate"];
    }
    return associateUrl;
}

+ (NSString *)getHotSpotsUrl {
    static NSString *getHotSpotsUrl = nil;
    if (getHotSpotsUrl == nil) {
        getHotSpotsUrl = [NSString stringWithFormat:@"%@%@", API_URL, @"hotspots"];
    }
    return getHotSpotsUrl;
}

+ (NSString *)createHotSpotUrl {
    static NSString *createHotSpotUrl = nil;
    if (createHotSpotUrl == nil) {
        createHotSpotUrl = [NSString stringWithFormat:@"%@%@", API_URL, @"hotspot"];
    }
    return createHotSpotUrl;
}

+ (NSString *)fetchHotSpotUrl:(NSString *)lat lng:(NSString *)lng {
    static NSString *fetchHotSpotUrl = nil;
    if (fetchHotSpotUrl == nil) {
        fetchHotSpotUrl = [NSString stringWithFormat:@"%@hotspot", API_URL];
    }
    return [NSString stringWithFormat:@"%@/%@/%@", fetchHotSpotUrl, lat, lng];;
}

@end
