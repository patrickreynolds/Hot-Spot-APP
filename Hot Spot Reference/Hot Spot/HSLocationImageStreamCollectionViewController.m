//
//  HSLocationImageStreamCollectionViewController.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 3/13/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HSLocationImageStreamCollectionViewController.h"
#import "HSLocationImageCollectionViewCell.h"
#import "InstaFetcher.h"
#import "InstagramAPIKey.h"
#import "InstagramLocaiton.h"
#import "InstagramMedia.h"

@interface HSLocationImageStreamCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *hotspotLocationPhotos;

@end

@implementation HSLocationImageStreamCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.title = self.location.name;
    
    InstagramLocaiton *location = [InstaFetcher getLocationInfoForLocationName:self.location.name withLatitude:[NSString stringWithFormat:@"%f", [self.location.latitude doubleValue]] andLongitude:[NSString stringWithFormat:@"%f", [self.location.longitude doubleValue]]];
    
    self.hotspotLocationPhotos = location.locationPhotos;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.hotspotLocationPhotos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HSLocationImageCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LocationPhotoInfo" forIndexPath:indexPath];
    myCell.imageView.image = nil;
    myCell.username.text = nil;
    myCell.profilePicture.image = nil;
    myCell.currentTime.text = nil;
    myCell.likeCount.text = nil;
    // Initializing instance of picture
    InstagramMedia* pictureInfo = [self.hotspotLocationPhotos objectAtIndex:indexPath.row];
    NSLog(@"Picture Info: %@", [self.hotspotLocationPhotos objectAtIndex:indexPath.row]);
    
    dispatch_queue_t downloadImageQueue = dispatch_queue_create("image downloader", NULL);
    dispatch_async(downloadImageQueue, ^{
        // Getting Image Data in secondary thread
        NSURL *imageViewUrl = pictureInfo.standard_resolution_url;
        NSData *imageViewData = [NSData dataWithContentsOfURL:imageViewUrl];
        
        // Profle Picture
        NSURL *profilePictureUrl = pictureInfo.owner.profile_picture;
        NSData *profilePictureData = [NSData dataWithContentsOfURL:profilePictureUrl];
        
        UIImage *primaryPicture = [[UIImage alloc] initWithData:imageViewData];
        UIImage *profilePicture = [[UIImage alloc] initWithData:profilePictureData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Getting date timestamp
            NSDate *date = pictureInfo.created_time;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setLocale:[NSLocale currentLocale]];
            [formatter setDateFormat:@"dd.MM.yyyy 'at' hh.mm a"];
            NSString *formattedDate = [formatter stringFromDate:date];
            
            // Assignming images to cell objects
            myCell.imageView.image = primaryPicture;
            myCell.username.text = pictureInfo.owner.username;
            myCell.profilePicture.image = profilePicture;
            myCell.currentTime.text = formattedDate;
            myCell.likeCount.text = [NSString stringWithFormat:@"%ld", (long)[pictureInfo.likes.count integerValue]];
        });
    });
    return myCell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
