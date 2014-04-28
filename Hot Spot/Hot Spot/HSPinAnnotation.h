//
//  HSPinAnnotation.h
//  Hot Spot
//
//  Created by Patrick Reynolds on 1/18/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface HSPinAnnotation : NSObject <MKAnnotation> {
    NSString *title;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)coord;

@end
