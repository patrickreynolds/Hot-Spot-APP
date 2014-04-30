//
//  SignupViewController.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "SignupViewControllerDelegate.h"

@interface SignupViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <SignupViewControllerDelegate> delegate;

@end
