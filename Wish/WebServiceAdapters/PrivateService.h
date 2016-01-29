//
//  PrivateService.h
//  AVTMobile
//
//  Created by Annie Klekchyan on 7/16/15.
//  Copyright (c) 2015 Annie Klekchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^getWishesCompletionHandler)(NSDictionary *result, BOOL isSucess);

@interface PrivateService : NSObject

+(PrivateService *)sharedInstance;

- (void) getWishesOnCompletion:(getWishesCompletionHandler)completionHandler;

@end
