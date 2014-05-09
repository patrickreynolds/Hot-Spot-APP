//
//  HotSpotMapAnnotation.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 08/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HotSpotMapAnnotation.h"

@implementation HotSpotMapAnnotation

- (id)initWithTitle:(NSString *)title andLocation:(CLLocationCoordinate2D)location {
    self = [super init];

    if (self) {
        _title = title;
        _coordinate = location;
    }

    return self;
}

- (MKAnnotationView *)annotationView {
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self
                                                                    reuseIdentifier:@"HotSpotMapAnnotation"];

    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.pinColor = MKPinAnnotationColorRed;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    return annotationView;
}

@end
