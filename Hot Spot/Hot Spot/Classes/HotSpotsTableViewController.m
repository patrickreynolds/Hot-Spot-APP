//
//  HotSpotsTableViewController.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 06/05/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HotSpotsTableViewController.h"

#import "LocalizedMediaStreamViewController.h"
#import "LocalizedMedia.h"

@interface HotSpotsTableViewController ()

@end

@implementation HotSpotsTableViewController

#pragma mark - UIViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LocalizedMediaStream"]) {
        LocalizedMediaStreamViewController *localizedMediaStream = segue.destinationViewController;
        localizedMediaStream.delegate = self;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotspotCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Title #%d", indexPath.row];
    
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

#pragma mark - LocalizedMediaStreamDelegate

- (NSInteger)numberOfLocalizedMedia {
    return 1;
}

- (LocalizedMedia *)localizedMediaForRow:(NSInteger)row {
    LocalizedMedia *localizedMedia = [LocalizedMedia new];

    localizedMedia.username = [NSString stringWithFormat:@"Username %d", row];

    return localizedMedia;
}

@end
