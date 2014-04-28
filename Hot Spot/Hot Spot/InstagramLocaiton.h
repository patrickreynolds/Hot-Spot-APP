//
//  InstagramLocaiton.h
//  InstaFetcher
//
//  Created by Patrick Reynolds on 1/21/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramLocaiton : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *maxTimeStamp;
@property (strong, nonatomic) NSString *minTimeStamp;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSMutableArray *locationPhotos;

- (instancetype)initLocaitonWith:(NSString *)name :(NSString *)maxTimeStamp :(NSString *)minTimeStamp :(NSString *)latitude :(NSString *)longitude :(NSMutableArray *)locationPhotos;

@end
