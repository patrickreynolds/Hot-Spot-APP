//
//  InstagramComments.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 12/11/13.
//  Copyright (c) 2013 Patrick Reynolds. All rights reserved.
//

#import "MediaComments.h"
#import "MediaCaption.h"

@implementation MediaComments
@synthesize count;

- (MediaComments *)initMediaComments :(NSMutableDictionary* )withMediaCommentData
{
    self = [super init];
    
    self.commentData = withMediaCommentData;
    
    return self;
}

- (NSNumber *)count
{
    if (![[self.commentData objectForKey:@"count"] isKindOfClass:[NSNull class]]) {
        return [NSNumber numberWithInteger:[[self.commentData objectForKey:@"count"] integerValue]];
    } else {
        return nil;
    }
}


// Returns an array of MediaCaptions (User info and comment details.)
// *Important Point* if the media contains more than 4 comments, use the
// additional InstagramMedia::allComments to retrieve a complete list of
// users that have liked an image.
- (NSArray *)captions
{
    NSMutableArray *comments = [[NSMutableArray alloc] init];
    if ([[self count] isEqualToNumber:[NSNumber numberWithInt:0]]) {
        comments = nil;
    } else {
        NSArray *commentDataArray = [[NSArray alloc] initWithArray:[self.commentData objectForKey:@"data"]];
        
        int counter = 0;
        for(NSDictionary *caption in commentDataArray) {
            MediaCaption *newCaption = [[MediaCaption alloc] initCaption:[commentDataArray objectAtIndex:counter]];
            [comments addObject:newCaption];
            counter++;
        }
    }
    return (NSArray *)comments;
}


@end
