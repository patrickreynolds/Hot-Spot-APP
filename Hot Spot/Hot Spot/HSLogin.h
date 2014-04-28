//
//  HSViewController.h
//  Hot Spot
//
//  Created by Patrick Reynolds on 12/14/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSLogin : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameInput;
@property (strong, nonatomic) IBOutlet UITextField *passwordInput;


- (IBAction)signUp:(id)sender;


// Keyboard Methods
- (IBAction)usernameReturn:(id)sender;
- (IBAction)passwordReturn:(id)sender;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
