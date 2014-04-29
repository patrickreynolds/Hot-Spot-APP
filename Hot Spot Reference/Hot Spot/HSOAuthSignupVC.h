//
//  HSOAuthSignupVC.h
//  Hot Spot
//
//  Created by Patrick Reynolds on 1/17/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSOAuthSignupVC : UIViewController <UIWebViewDelegate>

@property (strong, readonly) NSString *access_token;

@end
