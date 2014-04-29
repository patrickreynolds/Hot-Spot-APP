//
//  InstagramComments.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/11/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaComments : NSObject

@property (strong, nonatomic) NSDictionary *commentData;

// Number of comments that were passed in the withMediaCommentData dictionary.
@property (strong, nonatomic, readonly) NSNumber* count;

// Returns an array of MediaCaptions (User info and comment details.)
@property (strong, nonatomic, readonly) NSArray* captions;

- (MediaComments *)initMediaComments :(NSMutableDictionary* )withMediaCommentData;

@end
