//
//  HSPhotoFeed.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 12/14/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "HSPhotoFeed.h"

@interface HSPhotoFeed ()

@end

@implementation HSPhotoFeed

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
	// Do any additional setup after loading the view.
    [[HSGlobalManager alloc] initGlobalManager:@"801cf1d44fcd43f99cbb38781d7cb227"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
