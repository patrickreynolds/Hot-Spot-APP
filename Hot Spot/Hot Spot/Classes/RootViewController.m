//
//  RootViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "RootViewController.h"

#import <StoryboardSupport/UIStoryboard+MainStoryboard.h>
#import "SignupViewController.h"
#import "LoginViewController.h"
#import "LoggedViewController.h"

@implementation RootViewController

#pragma mark - Methods

//
// Called by Splash and Logged view controllers
- (void)goToLogin {
    LoginViewController *loginViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"Login"];

    if ([self.topViewController class] == [LoggedViewController class]) {
        // Logged: Logout
        NSArray *newViewControllers = @[loginViewController, self.topViewController];
        [self setViewControllers:newViewControllers animated:NO];
        [self popToRootViewControllerAnimated:YES];
    } else {
        // Splash: Autologin failed
        [self setViewControllers:@[loginViewController] animated:YES];
    }
}

//
// Called by Login view controller
- (void)showSignup {
    SignupViewController *signupViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"Signup"];
    signupViewController.delegate = (LoginViewController *)self.topViewController;

    [self presentViewController:signupViewController animated:YES completion:nil];
}

//
// Called by Splash, Login (before/after signup) view controllers
- (void)goToAssociate {
    [self setViewControllers:@[[[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"Associate"]] animated:YES];
}

//
// Called by Splash, Login, Associate view controllers
- (void)goToLogged {
    [self setViewControllers:@[[[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"Logged"]] animated:YES];
}

@end
