//
//  HSPinAnnotation.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 1/18/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HSPinAnnotation.h"

@implementation HSPinAnnotation
@synthesize title, coordinate;


- (instancetype)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)coord
{
    self = [super init];
    self.title = ttl;
    self.coordinate = coord;
    return self;
}

@end
