//
//  API.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

@interface API : NSObject

+ (NSString *)signupUrl;
+ (NSString *)loginUrl;
+ (NSString *)associateUrl;
+ (NSString *)getHotSpotsUrl;
+ (NSString *)createHotSpotUrl;
+ (NSString *)fetchHotSpotUrl:(NSString *)lat lng:(NSString *)lng;
+ (NSString *)deleteHotSpotUrl:(NSString *)hotSpotId;
+ (NSString *)getFeedUrl;

@end
