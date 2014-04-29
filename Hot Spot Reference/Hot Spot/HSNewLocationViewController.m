//
//  HSNewLocationViewController.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 3/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HSNewLocationViewController.h"
#import "HSLocationManager.h"
#import "HSLocation.h"

@interface HSNewLocationViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *locationNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationLatitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationLongitudeTextField;

@end

@implementation HSNewLocationViewController

- (instancetype)initForNewLocation:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                         target:self
                                         action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                           target:self
                                           action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //HSLocation *location = self.location;
    self.locationLatitudeTextField.text = [NSString stringWithFormat:@"%f", [self.location.latitude doubleValue]];
    self.locationLongitudeTextField.text = [NSString stringWithFormat:@"%f", [self.location.longitude doubleValue]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    //HSLocation *location = self.location;
    self.location.name = self.locationNameTextField.text;
    self.location.latitude = [NSNumber numberWithDouble:[self.locationLatitudeTextField.text doubleValue]];
    self.location.longitude = [NSNumber numberWithDouble:[self.locationLongitudeTextField.text doubleValue]];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Save Action.");
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:self.dismissBlock];
}

- (IBAction)cancel:(id)sender
{
    // If the user cancelled, then remove the BNRItem from the store
    [[HSLocationManager locationStore] removeLocation:self.location];
    
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"Test");
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}


@end
