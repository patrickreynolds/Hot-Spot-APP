//
//  HSAppDelegate.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 12/14/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "HSAppDelegate.h"
#import "HSLocationManager.h"
#import "HSLocation.h"

@implementation HSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSLog(@"Did finish launching with options");
    HSLocation *newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Golden Gate Bridge";
    newLocation.latitude = @37.808902;
    newLocation.longitude = @-122.476966;
    
    newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Hollywood Sign";
    newLocation.latitude = @34.13408;
    newLocation.longitude = @-118.321792;
    
    newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Colosseum";
    newLocation.latitude = @41.890298;
    newLocation.longitude = @12.49231;
    
    newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Christ The Redeemer";
    newLocation.latitude = @-22.951438;
    newLocation.longitude = @-43.210841;
    
    newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Big Ben";
    newLocation.latitude = @51.500836;
    newLocation.longitude = @-0.124547;
    
    newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Time Square";
    newLocation.latitude = @40.759265;
    newLocation.longitude = @-73.984896;
    
    newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Arc De Triomphe";
    newLocation.latitude = @48.874214;
    newLocation.longitude = @2.295066;
    
    newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Sydney Opera House";
    newLocation.latitude = @-33.857694;
    newLocation.longitude = @151.214701;
    
    newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Statue Of Liberty";
    newLocation.latitude = @40.689278;
    newLocation.longitude = @-74.044508;
    
    newLocation = [[HSLocationManager locationStore] createLocation];
    newLocation.name = @"Eiffel Tower";
    newLocation.latitude = @48.858122;
    newLocation.longitude = @2.294616;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [[HSLocationManager locationStore] saveChanges];
    if (success) {
        NSLog(@"Saved all of the HSLocations");
    } else {
        NSLog(@"Could not save any of the HSLocations");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
