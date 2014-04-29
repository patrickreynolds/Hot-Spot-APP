//
//  InstagramVideo.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/9/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "InstagramVideo.h"
#import "MediaCaption.h"

@implementation InstagramVideo

- (InstagramVideo *)initVideo:(NSMutableDictionary *)withVideoData
{
    //InstagramVideo* video = [[InstagramVideo alloc] init];
    self = [super init];
    
    self.mediaData = withVideoData;
    
    return self;
}

/*
- (NSURL *)low_resolution_video_url
{
    
}

- (NSURL *)standard_resolution_video_url
{
    
}
 */


@end
