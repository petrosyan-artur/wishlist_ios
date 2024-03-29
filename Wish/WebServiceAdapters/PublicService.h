//
//  PublicService.h
//  Wish
//
//  Created by Annie Klekchyan on 1/18/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^getConfigurationCompletionHandler)(NSDictionary* result, BOOL isSucess);
typedef void (^authenticateCompletionHandler)(NSDictionary* result, BOOL isSucess);
typedef void (^getUserNameCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^registerUserCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^getWishesCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^isNewWishesCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^getWishesWithUserIDCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^getWishesWithLimitCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^getOtherWishesWithLimitCompletionHandler)(NSDictionary *result, BOOL isSucess);

@interface PublicService : NSObject

+ (PublicService *)sharedInstance;

- (void) getConfigurationOnCompletion:(getConfigurationCompletionHandler)completionHandler;
- (void) getUserNameOnCompletion:(getUserNameCompletionHandler)completionHandler;
- (void) registerUserWithUserName:(NSString *)username Password:(NSString *)password Password2:(NSString *)password2 OnCompletion:(registerUserCompletionHandler)completionHandler;
- (void) authenticateWithUsername:(NSString *)username  AndPassword:(NSString *)password OnCompletion:(authenticateCompletionHandler)completionHandler;
- (void) getWishesOnCompletion:(getWishesCompletionHandler)completionHandler;
- (void) isNewWishesWithLastWishID:(NSString *)lastWishID OnCompletion:(isNewWishesCompletionHandler)completionHandler;
- (void) getWishesWIthUserID:(NSString *) userID OnCompletion:(getWishesWithUserIDCompletionHandler)completionHandler;
- (void) getWishesWithLimit:(NSInteger)limit AndUserID:(NSString *)userID OnCompletion:(getWishesWithLimitCompletionHandler)completionHandler;
- (void) getWishesWithLimit:(NSInteger)limit OnCompletion:(getOtherWishesWithLimitCompletionHandler)completionHandler;
@end
