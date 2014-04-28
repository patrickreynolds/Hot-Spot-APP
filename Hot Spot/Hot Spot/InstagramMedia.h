//
//  InstagramMedia.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/9/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstagramUser.h"
#import "MediaCaption.h"
#import "MediaComments.h"
#import "MediaLikes.h"

@interface InstagramMedia : NSObject

@property (strong, nonatomic) NSMutableDictionary* mediaData;

@property (strong, nonatomic, readonly) NSArray* tags;
@property (strong, nonatomic, readonly) NSString* type;
@property (strong, nonatomic, readonly) NSString* latitude;
@property (strong, nonatomic, readonly) NSString* longitude;
@property (strong, nonatomic, readonly) MediaComments* comments;
@property (strong, nonatomic, readonly) NSString* filter;
@property (strong, nonatomic, readonly) NSDate* created_time;
@property (strong, nonatomic, readonly) NSURL* link;
@property (strong, nonatomic, readonly) MediaLikes* likes;
@property (strong, nonatomic, readonly) NSURL* thumbnail_url;
@property (strong, nonatomic, readonly) NSURL* low_resolution_url;
@property (strong, nonatomic, readonly) NSURL* standard_resolution_url;
@property (strong, nonatomic, readonly) NSMutableArray* users_in_photo;
@property (strong, nonatomic, readonly) MediaCaption* caption;
@property (strong, nonatomic, readonly) NSString* user_has_liked;
@property (strong, nonatomic, readonly) NSString* media_id;
@property (strong, nonatomic, readonly) InstagramUser* owner;


// Initializing caption instance info from NSMutableDictionary data
- (InstagramMedia *)initMedia :(NSMutableDictionary *)withMediaData;

// Returns an array of InstagramUser objects who have likes this piece of media.
- (NSArray *)allLikes;
- (NSArray *)allComments;

@end
