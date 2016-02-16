//
//  PrivateService.h
//  AVTMobile
//
//  Created by Annie Klekchyan on 7/16/15.
//  Copyright (c) 2015 Annie Klekchyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WishObject.h"

typedef void (^getWishesCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^postWishCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^getWishesWithLimitCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^likeWishesCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^dislikeWishesCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^getMyWishesCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^getMyWishesWithLimitCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^getMyLikesCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^getMyLikesWithLimitCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^editWishCompletionHandler)(NSDictionary *result, BOOL isSucess);

@interface PrivateService : NSObject

+(PrivateService *)sharedInstance;

- (void) getWishesOnCompletion:(getWishesCompletionHandler)completionHandler;
- (void) postWishWithContent:(NSString *)content Color:(NSString *)color AndImage:(NSString *)imageURL OnCompletion:(postWishCompletionHandler)completionHandler;
- (void) getWishesWitLimit:(NSInteger)limit OnCompletion:(getWishesWithLimitCompletionHandler)completionHandler;
- (void) likeWishWithUserID:(NSString *)userID AndWishID:(NSString *) wishID OnCompletion:(likeWishesCompletionHandler)completionHandler;
- (void) dislikeWishWithUserID:(NSString *)userID AndWishID:(NSString *) wishID OnCompletion:(dislikeWishesCompletionHandler)completionHandler;
- (void) getMyWishesWIthUserID:(NSString *) userID OnCompletion:(getMyWishesCompletionHandler)completionHandler;
- (void) getMyWishesWitLimit:(NSInteger)limit OnCompletion:(getMyWishesWithLimitCompletionHandler)completionHandler;
- (void) getMyLikesWIthUserID:(NSString *) userID OnCompletion:(getMyLikesCompletionHandler)completionHandler;
- (void) getMyLikesWitLimit:(NSInteger)limit OnCompletion:(getMyLikesWithLimitCompletionHandler)completionHandler;
- (void) editWishWithWishObject:(WishObject *)wish OnCompletion:(editWishCompletionHandler)completionHandler;

@end
