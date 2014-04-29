//
//  HSLocationSearch.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 12/14/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "HSLocationSearchVC.h"
#import "HSNewLocationViewController.h"
#import "HSPinAnnotation.h"
#import "HSLocationManager.h"
#import "HSLocation.h"
#import <MapKit/MapKit.h>

@interface HSLocationSearchVC () <MKMapViewDelegate>

@property (strong, nonatomic) NSMutableArray *mapAnnotations;

@property (strong, nonatomic) NSNumber *selectedLatitude;
@property (strong, nonatomic) NSNumber *selectedLongitude;

@end

@implementation HSLocationSearchVC

- (void)viewDidLoad
{
    UINavigationItem *navItem = self.navigationItem;
    
    // Create a new bar button item that will send
    // addNewItem: to BNRItemsViewController
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
    
    // set this bar button item as the right item in the navigationItem
    navItem.rightBarButtonItem = barButtonItem;
}

- (NSMutableArray *)mapAnnotations
{
    if (!_mapAnnotations) _mapAnnotations = [[NSMutableArray alloc] init];
    return _mapAnnotations;
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    self.mapView.delegate = self;
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                      action:@selector(addPin:)];
    [tapped setNumberOfTapsRequired:1];
    [self.mapView addGestureRecognizer:tapped];
}

- (void)addPin:(UIGestureRecognizer *)gestureRecognizer
{
        NSLog(@"addPin was called.");
    [self.mapView removeAnnotations:self.mapAnnotations];
    [self.mapAnnotations removeAllObjects];
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
        NSLog(@"Coordinate Latitude: %f", touchMapCoordinate.latitude);
        NSLog(@"Coordinate Longitude: %f", touchMapCoordinate.longitude);
    self.selectedLatitude = [NSNumber numberWithDouble:touchMapCoordinate.latitude];
    NSLog(@"Selected Latitude: %f", [self.selectedLatitude doubleValue]);
    self.selectedLongitude = [NSNumber numberWithDouble:touchMapCoordinate.longitude];
    NSLog(@"Selected Longitude: %f", [self.selectedLongitude doubleValue]);
    
    HSPinAnnotation *annotation = [[HSPinAnnotation alloc] initWithTitle:@"Add Location" andCoordinate:touchMapCoordinate];
    annotation.title = @"Add Location";
    annotation.coordinate = touchMapCoordinate;
    [self.mapAnnotations addObject:annotation];
    [self.mapView addAnnotations:self.mapAnnotations];
    //[self.mapView selectAnnotation:[[self.mapView annotations] objectAtIndex:0] animated:YES];
}

- (IBAction)addNewItem:(id)sender
{
    
    // Create a new BNRItem and add it to the store
    HSLocation *newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.latitude = self.selectedLatitude;
    newLocation.longitude = self.selectedLongitude;
    
    HSNewLocationViewController *newLocationVC =
    [[HSNewLocationViewController alloc] initForNewLocation:YES];
    
    newLocationVC.location = newLocation;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newLocationVC];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.restorationIdentifier = NSStringFromClass([navigationController class]);
    
    [self presentViewController:navigationController animated:YES completion:nil];
}


@end
