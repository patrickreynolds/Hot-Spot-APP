//
//  LoginViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "LoginViewController.h"

#import "RootViewController.h"
#import "SignupViewController.h"
#import "User.h"
#import "Session.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation LoginViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.email.delegate = self;
    self.password.delegate = self;
}

#pragma mark - IBAction

- (IBAction)didTapLogIn:(UIButton *)sender {
    if (!sender.isEnabled) {
        return ;
    }
    sender.enabled = NO;
    [[User CurrentUser] login:self.email.text
                     password:self.password.text
                      success:^(id responseObject) {
                          [Session storeSessionToken:responseObject[@"sessionToken"] andUserId:responseObject[@"userId"]];
                          [(RootViewController *)self.navigationController goToLogged];
                          sender.enabled = YES;
                      }
                      failure:^(NSInteger statusCode, NSError *error, id responseObject) {
                          if (statusCode == 403) {
                              [Session storeSessionToken:responseObject[@"sessionToken"] andUserId:responseObject[@"userId"]];
                              [(RootViewController *)self.navigationController goToAssociate];
                          } else if (statusCode == 400 || statusCode == 404) {
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

- (IBAction)didTapSignUp:(UIButton *)sender {
    [(RootViewController *)self.navigationController showSignup];
}

#pragma mark - SignupViewControllerDelegate

- (void)dismissSignupViewController:(UIViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:^{
        [(RootViewController *)self.navigationController goToAssociate];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.email) {
        [textField resignFirstResponder];
        [self.password becomeFirstResponder];
    } else if (textField == self.password) {
        [textField resignFirstResponder];
        [self didTapLogIn:self.login];
    }
    return YES;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
