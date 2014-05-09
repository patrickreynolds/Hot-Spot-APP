//
//  User.m
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "User.h"

#import <AFNetworking/AFNetworking.h>
#import "API.h"

@implementation User

+ (User *)CurrentUser {
    static User *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[User alloc] init];
    });

    return _sharedInstance;
}

- (void)initWithResponseObject:(NSDictionary *)responseObject {
    if (responseObject[@"userId"]) {
        self.userId = responseObject[@"userId"];
    }
    if (responseObject[@"sessionToken"]) {
        self.sessionToken = responseObject[@"sessionToken"];
    }
}

- (void)signup:(NSString *)email
      password:(NSString *)password
       success:(UserSuccessBlock)success
       failure:(UserFailureBlock)failure {
    NSDictionary *parameters = @{@"email":email, @"password":password};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[API signupUrl]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self initWithResponseObject:responseObject];
             success(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self initWithResponseObject:operation.responseObject];
             failure(operation.response.statusCode, error, operation.responseObject);
         }];
}

- (void)login:(NSString *)userId
 sessionToken:(NSString *)sessionToken
      success:(UserSuccessBlock)success
      failure:(UserFailureBlock)failure {
    NSDictionary *parameters = @{@"userId":userId, @"sessionToken":sessionToken};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[API loginUrl]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self initWithResponseObject:responseObject];
             success(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self initWithResponseObject:operation.responseObject];
             failure(operation.response.statusCode, error, operation.responseObject);
         }];
}

- (void)login:(NSString *)email
     password:(NSString *)password
      success:(UserSuccessBlock)success
      failure:(UserFailureBlock)failure {
    NSDictionary *parameters = @{@"email":email, @"password":password};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[API loginUrl]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self initWithResponseObject:responseObject];
             success(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self initWithResponseObject:operation.responseObject];
             failure(operation.response.statusCode, error, operation.responseObject);
         }];
}

- (void)associate:(NSString *)accessToken
          success:(UserSuccessBlock)success
          failure:(UserFailureBlock)failure {
    NSDictionary *parameters = @{@"sessionToken":self.sessionToken, @"instagramSessionToken":accessToken};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[API associateUrl]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             success(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(operation.response.statusCode, error, operation.responseObject);
         }];
}

- (void)getHotSpots:(UserSuccessBlock)success
            failure:(UserFailureBlock)failure {
    NSDictionary *parameters = @{@"sessionToken":self.sessionToken};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[API getHotSpotsUrl]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              success(responseObject);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(operation.response.statusCode, error, operation.responseObject);
          }];
}

- (void)fetchHotSpot:(NSString *)lat
                 lng:(NSString *)lng
             success:(UserSuccessBlock)success
             failure:(UserFailureBlock)failure {
    NSString *url = [API fetchHotSpotUrl:lat lng:lng];
    NSDictionary *parameters = @{@"sessionToken":self.sessionToken};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             success(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(operation.response.statusCode, error, operation.responseObject);
         }];
}

@end
