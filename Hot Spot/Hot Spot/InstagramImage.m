//
//  InstagramImage.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/9/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "InstagramImage.h"

@implementation InstagramImage

- (InstagramImage *)initImage:(NSMutableDictionary *)withImageData
{
    // Inherits from InstagramMedia
    self = [super init];
    
    // Initializing with image data
    self.mediaData = withImageData;
    
    return self;
}


@end
