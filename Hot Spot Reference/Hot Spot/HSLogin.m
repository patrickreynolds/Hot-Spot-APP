//
//  HSViewController.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 12/14/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "HSLogin.h"

@interface HSLogin ()

@end

@implementation HSLogin

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (IBAction)signUp:(id)sender {
    //////////////-----------------------------------------------------------
    
    
    //NSString *accessToken = @"801cf1d44fcd43f99cbb38781d7cb227";
    //NSString *clientID = @"801cf1d44fcd43f99cbb38781d7cb227";
    //NSString *clientSecret = @"f768ff10426f4cc2a6a8e6688b45a39f";
        
    
    // CLIENT ID:       801cf1d44fcd43f99cbb38781d7cb227
    // CLIENT SECRET	f768ff10426f4cc2a6a8e6688b45a39f
    
    // 801cf1d44fcd43f99cbb38781d7cb227://authorize

    
    
    
    //////////////-----------------------------------------------------------
    
}

- (IBAction)usernameReturn:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)passwordReturn:(id)sender {
    [sender resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.passwordInput isFirstResponder] && [touch view] != self.passwordInput) {
        [self.passwordInput resignFirstResponder];
    }
    
    if([self.usernameInput isFirstResponder] && [touch view] != self.usernameInput) {
        [self.usernameInput resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Login"]) {
    }
}

@end
