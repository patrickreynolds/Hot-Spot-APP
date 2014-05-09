//
//  HotSpotMapAnnotation.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 08/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface HotSpotMapAnnotation : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;


- (id)initWithTitle:(NSString *)title andLocation:(CLLocationCoordinate2D)location;
- (MKAnnotationView *)annotationView;

@end
