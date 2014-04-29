//
//  HSLocationManager.h
//  Hot Spot
//
//  Created by Patrick Reynolds on 3/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSLocation;

@interface HSLocationManager : NSObject

@property (nonatomic, readonly) NSArray *allLocations;

+ (instancetype)locationStore;

- (HSLocation *)createLocation;
- (void)removeLocation:(HSLocation *)location;
- (void)moveLocationAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
- (BOOL)saveChanges;

@end
