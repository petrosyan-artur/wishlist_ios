//
//  PrivateService.h
//  AVTMobile
//
//  Created by Annie Klekchyan on 7/16/15.
//  Copyright (c) 2015 Annie Klekchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^getWishesCompletionHandler)(NSDictionary *result, BOOL isSucess);
typedef void (^postWishCompletionHandler)(NSDictionary *result, BOOL isSucess);

@interface PrivateService : NSObject

+(PrivateService *)sharedInstance;

- (void) getWishesOnCompletion:(getWishesCompletionHandler)completionHandler;
- (void) postWishWithContent:(NSString *)content Color:(NSString *)color AndImage:(NSString *)imageURL OnCompletion:(postWishCompletionHandler)completionHandler;

@end
