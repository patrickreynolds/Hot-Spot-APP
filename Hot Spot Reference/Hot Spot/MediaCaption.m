//
//  MediaCaption.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/10/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "MediaCaption.h"

@implementation MediaCaption

- (MediaCaption *)initCaption :(NSMutableDictionary *)withCaptionData
{
    self = [super init];
    
    self.captionData = withCaptionData;
    
    return self;
}

- (NSString *)createdTime
{
    return [self.captionData objectForKey:@"created_time"];
}

- (NSString *)from_full_name
{
    if ([[self.captionData objectForKey:@"from"] objectForKey:@"full_name"]) {
        return [[self.captionData objectForKey:@"from"] objectForKey:@"full_name"];
    } else {
        return nil;
    }
}

- (NSString *)from_id
{
    return [[self.captionData objectForKey:@"from"] objectForKey:@"id"];
}

- (NSString *)from_profile_picture
{
    return [[self.captionData objectForKey:@"from"] objectForKey:@"profile_picture"];
}

- (NSString *)from_username
{
    return [[self.captionData objectForKey:@"from"] objectForKey:@"username"];
}

- (NSString *)captionId
{
    return [self.captionData objectForKey:@"id"];
}

- (NSString *)text
{
    if (![[self.captionData objectForKey:@"text"] isKindOfClass:[NSNull class]]) {
        return [self.captionData objectForKey:@"text"];
    } else {
        return nil;
    }
}


@end
