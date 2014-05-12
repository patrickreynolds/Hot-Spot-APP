//
//  CreateHotSpotViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 10/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "CreateHotSpotViewController.h"

#import "User.h"

@interface CreateHotSpotViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation CreateHotSpotViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.nameTextField.delegate = self;
    self.descriptionTextField.delegate = self;
}

- (IBAction)didTapSave:(UIButton *)sender {
    sender.enabled = NO;
    self.cancelButton.enabled = NO;

    [[User CurrentUser] createHotSpot:self.nameTextField.text
                          description:self.descriptionTextField.text
                                  lat:[[NSNumber numberWithDouble:self.coordinate.latitude] stringValue]
                                  lng:[[NSNumber numberWithDouble:self.coordinate.longitude] stringValue]
                              success:^(id responseObject) {
                                  [self dismissViewControllerAnimated:YES completion:^{
                                      sender.enabled = YES;
                                      self.cancelButton.enabled = YES;
                                  }];
                              }
                              failure:^(NSInteger statusCode, NSError *error, id responseObject) {
                                  //TODO: statusCode
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
                                  self.cancelButton.enabled = YES;
                              }];
}

- (IBAction)didTapCancel:(UIButton *)sender {
    sender.enabled = NO;
    self.saveButton.enabled = NO;

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [textField resignFirstResponder];
        [self.descriptionTextField becomeFirstResponder];
    } else if (textField == self.descriptionTextField) {
        [textField resignFirstResponder];
        [self didTapSave:self.saveButton];
    }
    return YES;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
