//
//  MediaLikes.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/11/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "MediaLikes.h"
#import "InstagramUser.h"
#import "DataFetcher.h"

@implementation MediaLikes

- (MediaLikes *)initMediaLikes:(NSMutableDictionary *)withMediaLikesData
{
    self = [super init];
    
    self.likesData = withMediaLikesData;
    
    return self;
}

- (NSNumber *)count
{
    return [NSNumber numberWithInteger:[[self.likesData objectForKey:@"count"] integerValue]];
}

// Returns an array of InstagramUsers that have liked this media.
// *Important Point* if the media contains more than 4 likes, use the
// additional InstagramMedia::allLikes to retrieve a complete list of
// users that have liked an image.
- (NSArray *)users
{
    NSMutableArray *likes = [[NSMutableArray alloc] init];
    if ([[self count] isEqualToNumber:[NSNumber numberWithInt:0]]) {
        likes = nil;
    } else {
        NSArray *likesDataArray = [[NSArray alloc] initWithArray:[self.likesData objectForKey:@"data"]];
        
        int counter = 0;
        for(NSDictionary *user in likesDataArray) {
            InstagramUser *newUser = [[InstagramUser alloc] initInstagramUser:[likesDataArray objectAtIndex:counter]];
            [likes addObject:newUser];
            counter++;
        }
    }
    
    // Returns an array of InstagramUsers.
    return (NSArray *)likes;
}

@end