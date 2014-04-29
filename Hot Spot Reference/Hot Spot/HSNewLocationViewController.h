//
//  HSNewLocationViewController.h
//  Hot Spot
//
//  Created by Patrick Reynolds on 3/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSLocation;

@interface HSNewLocationViewController : UIViewController

@property (strong, nonatomic) HSLocation *location;
@property (copy, nonatomic) void (^dismissBlock)(void);


- (instancetype)initForNewLocation:(BOOL)isNew;

@end
