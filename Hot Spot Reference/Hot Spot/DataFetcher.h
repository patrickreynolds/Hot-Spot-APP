//
//  DataFetcher.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 1/6/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFetcher : NSObject

// Takes an intial json response, and extracts out Instagram "pagination" url.
// Instagram uses a "pagination" protocol to retrieve a small number of data
// to minimize requests to the server. For example, when requesting media for a
// given username, instagram will only respond with 20 "media objects", and if there
// are more, they will also send back a pagination API address to continue fetching
// data at the position the requester last finished.
+ (NSString* )getPaginationUrl :(NSMutableDictionary *)response;

// This nice, convenient method takes the initial response from instagram, and
// will continue to retrieve and concatinate json objects until it no longer gets
// a pagination url in the response. Very useful for retrieving large data sets.
+ (NSMutableArray *)getAllObjectsFromPagination :(NSMutableDictionary *)firstRequest;

// Takes a http request url string and returns the response of json data in array form.
+ (NSMutableArray *)sendInstagramAPIRequest :(NSString *)url;

// Takes http request url as string and returns the response json data within the @"data" wrapper.
+ (NSMutableArray *)sendInstagramAPIRequestForDataObject :(NSString *)url;

@end
