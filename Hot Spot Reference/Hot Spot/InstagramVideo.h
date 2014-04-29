//
//  InstagramVideo.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/9/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "InstagramMedia.h"

@interface InstagramVideo : InstagramMedia

@property (strong, nonatomic, readonly) NSURL* low_resolution_video_url;
@property (strong, nonatomic, readonly) NSURL* standard_resolution_video_url;

// Initializing caption instance info from NSMutableDictionary data
- (InstagramVideo *)initVideo :(NSMutableDictionary *)withVideoData;

@end
