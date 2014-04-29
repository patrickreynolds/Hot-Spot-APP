//
//  MediaLikes.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/11/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaLikes : NSObject

@property (strong, nonatomic) NSDictionary *likesData;

@property (strong, nonatomic) NSNumber* count;
@property (strong, nonatomic) NSArray* users; // Array of users who have liked the photo

- (MediaLikes *)initMediaLikes :(NSMutableDictionary *)withMediaLikesData;

@end
