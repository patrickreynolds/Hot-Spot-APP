//
//  HotSpotsTableViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 06/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HotSpotsTableViewController.h"

#import "User.h"
#import "HotSpot.h"
#import "LocalizedMediaStreamViewController.h"
#import "LocalizedMedia.h"

@interface HotSpotsTableViewController ()

- (void)refreshHotSpots;

@end

@implementation HotSpotsTableViewController {
    NSMutableArray *hotspots; //Array HotSpot models
}

#pragma mark - Custom methods

- (void)refreshHotSpots {
    [hotspots removeAllObjects];
    [[User CurrentUser] getHotSpots:^(id responseObject) {
        for (NSDictionary *hotSpot in responseObject[@"hotspots"]) {
            HotSpot *newHotSpot = [HotSpot new];
            newHotSpot.name = hotSpot[@"name"];
            newHotSpot.description = hotSpot[@"description"];
            newHotSpot.coordinate = CLLocationCoordinate2DMake([hotSpot[@"lat"] doubleValue], [hotSpot[@"lng"] doubleValue]);
            newHotSpot.preview = NO;
            [hotspots addObject:newHotSpot];
        }
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }
                            failure:^(NSInteger statusCode, NSError *error, id responseObject) {
                                //TODO: statusCode
                                [self.refreshControl endRefreshing];
                                [[[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil] show];
                            }];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    hotspots = [NSMutableArray new];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshHotSpots)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self refreshHotSpots];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LocalizedMediaStream"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LocalizedMediaStreamViewController *localizedMediaStream = segue.destinationViewController;
        localizedMediaStream.delegate = localizedMediaStream;
        localizedMediaStream.hotspot = hotspots[indexPath.row];
    }
}

#pragma mark - UITableViewController

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

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [hotspots count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotspotCell"
                                                            forIndexPath:indexPath];
    HotSpot *hotSpot = hotspots[indexPath.row];

    cell.textLabel.text = hotSpot.name;
    cell.detailTextLabel.text = hotSpot.description;
    
    return cell;
}

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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

@end
