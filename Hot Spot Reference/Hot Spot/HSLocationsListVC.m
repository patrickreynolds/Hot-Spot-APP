//
//  HSLocationsList.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 12/14/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "HSLocationsListVC.h"
#import "HSLocationImageStreamCollectionViewController.h"
#import "HSNewLocationViewController.h"
#import "HSLocationManager.h"
#import "HSLocation.h"

@interface HSLocationsListVC ()

//@property (strong, nonatomic) UIBarButtonItem *editButton;

@end

@implementation HSLocationsListVC

#pragma mark - Initializers
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    BOOL success = [[HSLocationManager locationStore] saveChanges];
    if (success) {
        NSLog(@"Saved all of the HSLocations");
    } else {
        NSLog(@"Could not save any of the HSLocations");
    }
}

#pragma mark - Actions
- (IBAction)addNewItem:(id)sender
{
    HSLocation *newLocation = [[HSLocationManager locationStore] createLocation];
    
    HSNewLocationViewController *newLocationVC = [[HSNewLocationViewController alloc]
                                                  initForNewLocation:YES];
    
    newLocationVC.location = newLocation;
    
    newLocationVC.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc]
                                                    initWithRootViewController:newLocationVC];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    navController.restorationIdentifier = NSStringFromClass([navController class]);
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)toggleEditingMode:(id)sender
{
    // If you are currently in editing mode
    if (self.isEditing) {
        
        // Change text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        // Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        // Change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
        // Enter editing mode
        [self setEditing:YES animated:YES];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[HSLocationManager locationStore] allLocations] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HSLocationCell"
                                                            forIndexPath:indexPath];
    NSArray *locations = [[HSLocationManager locationStore] allLocations];
    HSLocation *location = locations[indexPath.row];
    
    cell.textLabel.text = location.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *locations = [[HSLocationManager locationStore] allLocations];
        HSLocation *location = locations[indexPath.row];
        
        [[HSLocationManager locationStore] removeLocation:location];
        
        // Also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //}
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[HSLocationManager locationStore] moveLocationAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}


/*
#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //self.sharedHSGlobalManager = [[HSGlobalManager alloc] init];
    self.sharedHSGlobalManager = [HSGlobalManager sharedHSGlobalManager];
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
    
    [self.sharedHSGlobalManager.hotSpots addObject:aroundMe];
    
    NSLog(@"Hot Spots Count: %lu", (unsigned long)[self.sharedHSGlobalManager.hotSpots count]);
    [self.tableView reloadData];
 
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
     
    [locationManager startUpdatingLocation];
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"locationsListToLocationsImages"])
    {
        HSLocationImageStreamCollectionViewController *photoCVC = [segue destinationViewController];
        photoCVC.location = [[HSLocationManager locationStore] allLocations] [[self.tableView indexPathForSelectedRow].row];
    }
}
 

@end
