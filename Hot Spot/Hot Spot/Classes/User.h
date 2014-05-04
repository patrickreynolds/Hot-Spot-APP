//
//  User.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *sessionToken;

typedef void (^UserSuccessBlock)(id responseObject);
typedef void (^UserFailureBlock)(NSInteger statusCode, NSError *error, id responseObject);

+ (User *)CurrentUser;
- (void)signup:(NSString *)email
      password:(NSString *)password
       success:(UserSuccessBlock)success
       failure:(UserFailureBlock)failure;
- (void)login:(NSString *)userId
 sessionToken:(NSString *)sessionToken
      success:(UserSuccessBlock)success
      failure:(UserFailureBlock)failure;
- (void)login:(NSString *)email
     password:(NSString *)password
      success:(UserSuccessBlock)success
      failure:(UserFailureBlock)failure;
- (void)associate:(NSString *)accessToken
          success:(UserSuccessBlock)success
          failure:(UserFailureBlock)failure;

@end
