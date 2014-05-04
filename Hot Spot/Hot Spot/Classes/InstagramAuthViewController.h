//
//  InstagramAuthViewController.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 03/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

@class InstagramAuthViewController;

@protocol InstagramAuthViewControllerDelegate <NSObject>

- (void)authViewController:(InstagramAuthViewController *)viewController didCompleteWithAuthCode:(NSString *)code;
- (void)authViewController:(InstagramAuthViewController *)viewController didFailWithError:(NSError *)error;
- (void)authViewControllerDidCancel:(InstagramAuthViewController *)viewController;

@end

@interface InstagramAuthViewController : UINavigationController

- (id)initWithURL:(NSURL *)url delegate:(id<InstagramAuthViewControllerDelegate>)delegate;
- (void)show;

@end