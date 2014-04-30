//
//  SignupViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "SignupViewController.h"

#import "User.h"
#import "Session.h"

@interface SignupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signup;

@end

@implementation SignupViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.email.delegate = self;
    self.password.delegate = self;
}

#pragma mark - IBAction

- (IBAction)didTapSignUp:(UIButton *)sender {
    if (!sender.isEnabled) {
        return ;
    }
    sender.enabled = NO;
    [[User CurrentUser] signup:self.email.text
                      password:self.password.text
                       success:^(id responseObject) {
                           [Session storeSessionToken:responseObject[@"sessionToken"] andUserId:responseObject[@"userId"]];
                           [self.delegate dismissSignupViewController:self];
                       }
                       failure:^(NSInteger statusCode, NSError *error, id responseObject) {
                           if (statusCode == 400 || statusCode == 409) {
                               [[[UIAlertView alloc] initWithTitle:@"Error"
                                                           message:responseObject[@"error"]
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil] show];
                           } else {
                               [[[UIAlertView alloc] initWithTitle:@"Error"
                                                           message:error.localizedDescription
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil] show];
                           }
                           sender.enabled = YES;
                       }];
}

- (IBAction)didTapLogIn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.email) {
        [theTextField resignFirstResponder];
        [self.password becomeFirstResponder];
    } else if (theTextField == self.password) {
        [theTextField resignFirstResponder];
        [self didTapSignUp:self.signup];
    }
    return YES;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
