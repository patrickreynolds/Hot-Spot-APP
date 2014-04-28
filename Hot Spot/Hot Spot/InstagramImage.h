//
//  InstagramImage.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/9/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "InstagramMedia.h"

@interface InstagramImage : InstagramMedia


// Initializing caption instance info from NSMutableDictionary data
- (InstagramImage *)initImage:(NSMutableDictionary *)withImageData;


@end
