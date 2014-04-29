//
//  MediaCaption.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/10/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaCaption : NSObject

@property (strong,nonatomic) NSDictionary *captionData;

@property (strong, nonatomic, readonly) NSString* createdTime;
@property (strong, nonatomic, readonly) NSString* from_full_name;
@property (strong, nonatomic, readonly) NSString* from_id;
@property (strong, nonatomic, readonly) NSString* from_profile_picture;
@property (strong, nonatomic, readonly) NSString* from_username;
@property (strong, nonatomic, readonly) NSString* captionId;
@property (strong, nonatomic, readonly) NSString* text;

// Initializing caption instance info from NSMutableDictionary data
- (MediaCaption *)initCaption :(NSMutableDictionary *)withCaptionData;

@end
