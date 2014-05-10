//
//  HotSpot.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 07/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface HotSpot : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (getter=isPreview) BOOL preview;

@end
