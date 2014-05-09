//
//  SearchViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 06/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "SearchViewController.h"

#import <StoryboardSupport/UIStoryboard+MainStoryboard.h>
#import "HotSpotMapAnnotation.h"
#import "LocalizedMediaStreamViewController.h"
#import "HotSpot.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) HotSpotMapAnnotation *hotSpotMapAnnotation;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addGestureRecogniserToMapView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.hotSpotMapAnnotation = [[HotSpotMapAnnotation alloc] initWithTitle:@"Preview"
                                                                andLocation:CLLocationCoordinate2DMake(32.851402, -117.273812)];
    [self.mapView addAnnotation:self.hotSpotMapAnnotation];
}

- (void)addGestureRecogniserToMapView {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(addPinToMap:)];
    longPress.minimumPressDuration = 0.5;
    [self.mapView addGestureRecognizer:longPress];
}

- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    if (self.hotSpotMapAnnotation) {
        [self.mapView removeAnnotation:self.hotSpotMapAnnotation];
    }
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint
                                                      toCoordinateFromView:self.mapView];

    self.hotSpotMapAnnotation = [[HotSpotMapAnnotation alloc] initWithTitle:@"Annotation"
                                                                andLocation:touchMapCoordinate];
    [self.mapView addAnnotation:self.hotSpotMapAnnotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if (![annotation isKindOfClass:[HotSpotMapAnnotation class]]) {
        return nil;
    }
    HotSpotMapAnnotation *hotSpotMapAnnotation = annotation;
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"HotSpotMapAnnotation"];

    if (annotationView == nil) {
        annotationView = hotSpotMapAnnotation.annotationView;
    } else {
        annotationView.annotation = annotation;
    }

    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    HotSpotMapAnnotation *hotSpotAnnotation = view.annotation;

    HotSpot *hotSpot = [HotSpot new];
    hotSpot.name = @"Preview";
    hotSpot.coordinate = hotSpotAnnotation.coordinate;

    LocalizedMediaStreamViewController *localizedMediaStreamViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"LocalizedMediaStream"];
    localizedMediaStreamViewController.delegate = localizedMediaStreamViewController;
    localizedMediaStreamViewController.hotspot = hotSpot;

    [self.navigationController pushViewController:localizedMediaStreamViewController
                                         animated:YES];
}

@end
