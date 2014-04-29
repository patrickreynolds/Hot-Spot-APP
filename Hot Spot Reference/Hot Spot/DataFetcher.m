//
//  DataFetcher.m
//  InstaFetcher
//
//  Created by Patrick Reynolds on 1/6/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "DataFetcher.h"

@implementation DataFetcher

// Takes an intial json response, and extracts out Instagram "pagination" url.
// Instagram uses a "pagination" protocol to retrieve a small number of data
// to minimize requests to the server. For example, when requesting media for a
// given username, instagram will only respond with 20 "media objects", and if there
// are more, they will also send back a pagination API address to continue fetching
// data at the position the requester last finished.
+ (NSString* )getPaginationUrl :(NSMutableDictionary *)response
{
    if ([[response objectForKey:@"pagination"] objectForKey:@"next_url"]) {
        NSString* paginationURL = [[NSString alloc] initWithFormat:@"%@", [[response objectForKey:@"pagination"] objectForKey:@"next_url"]];
        return paginationURL;
    } else {
        return @"No more content.";
    }
}


// This nice, convenient method takes the initial response from instagram, and
// will continue to retrieve and concatinate json objects until it no longer gets
// a pagination url in the response. Very useful for retrieving large data sets.
+ (NSMutableArray *)getAllObjectsFromPagination :(NSMutableDictionary *)firstRequest
{
    if ([[self getPaginationUrl:firstRequest] isEqualToString:@"No more content."]) {
        return (NSMutableArray *)[firstRequest objectForKey:@"data"];
    }
    
    NSMutableArray* allObjects = [[NSMutableArray alloc] init];
    NSMutableDictionary* newRequest = firstRequest;
    
    while (![[self getPaginationUrl:newRequest] isEqualToString:@"No more content."]) {
        [allObjects addObjectsFromArray:(NSMutableArray *)[newRequest objectForKey:@"data"]];
        
        NSString* nextURL = [self getPaginationUrl:newRequest];
        NSData* requestData = [NSData dataWithContentsOfURL:[NSURL URLWithString:nextURL]];
        NSError* error = nil;
        newRequest = [NSJSONSerialization JSONObjectWithData:requestData options:kNilOptions error:&error];
    }
    
    [allObjects addObjectsFromArray:(NSMutableArray *)[newRequest objectForKey:@"data"]];
    return allObjects;
}


// Takes a http request url string and returns the response of json data in array form.
+ (NSMutableArray *)sendInstagramAPIRequest :(NSString *)url
{
    NSData* requestData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSError* error = nil;
    
    // Retrieve json response as NSMutableDictionary
    NSMutableDictionary* requestResponse = [NSJSONSerialization JSONObjectWithData:requestData options:kNilOptions error:&error];
    
    // Retrieve all json objects from Instagram Pagination
    NSMutableArray* allObjects = [DataFetcher getAllObjectsFromPagination:requestResponse];
    
    return allObjects;
}


// Takes http request url as string and returns the response json data within the @"data" wrapper.
+ (NSMutableArray *)sendInstagramAPIRequestForDataObject :(NSString *)url
{
    NSData* requestData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSError* error = nil;
    
    // Retrieve json response as NSMutableDictionary
    NSMutableDictionary* requestResponse = [NSJSONSerialization JSONObjectWithData:requestData options:kNilOptions error:&error];
    
    return (NSMutableArray *)[requestResponse objectForKey:@"data"];
}

@end
