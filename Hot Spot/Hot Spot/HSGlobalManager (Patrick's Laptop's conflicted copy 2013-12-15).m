//
//  HSGlobalManager.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 12/14/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "HSGlobalManager.h"

@implementation HSGlobalManager{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@synthesize currentLatitude, currentLongitude;

+ (HSGlobalManager *)sharedHSGlobalManager
{
    static HSGlobalManager *sharedHSGlobalManager;
    
    @synchronized(self)
    {
        if (!sharedHSGlobalManager)
            sharedHSGlobalManager = [[HSGlobalManager alloc] init];
        
        return sharedHSGlobalManager;
    }
}

- (void)initGlobalManager :(NSString* )withAccessToken
{
    // Set Global access token
    self.access_token = withAccessToken;
    
    // Initializing Global InstaFetch Instance
    InstaFetcher* instaFetcher = [[InstaFetcher alloc] init:self.access_token];
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    //placemark = [[CLPlacemark alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    NSLog(@"Latitude: %@", self.currentLatitude);
    NSLog(@"Longitude: %@", self.currentLongitude);
    
    //InstagramLocation* aroundMe = [[InstagramLocation alloc] initLocationPhotosWithAttributes:@"Around Me" :self.currentLatitude :self.currentLongitude];

    //[self.hotSpots addObject:aroundMe];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.currentLongitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.currentLatitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    
    InstagramLocation* aroundMe = [[InstagramLocation alloc] initLocationPhotosWithAttributes:@"Around Me" :self.currentLatitude :self.currentLongitude];
    
    NSLog(@"Latitude: %@", self.currentLatitude);
    NSLog(@"Longitude: %@", self.currentLongitude);
    
    [self.hotSpots addObject:aroundMe];
    
    /*
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            currentAddressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                        placemark.subThoroughfare, placemark.thoroughfare,
                                        placemark.locality, placemark.postalCode,
                                        placemark.administrativeArea,
                                        placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
     */
}


@end
