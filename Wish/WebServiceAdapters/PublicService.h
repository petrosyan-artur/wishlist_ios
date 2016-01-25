//
//  PublicService.h
//  Wish
//
//  Created by Annie Klekchyan on 1/18/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^getConfigurationCompletionHandler)(NSDictionary* result, NSError *error);
typedef void (^authenticateCompletionHandler)(NSDictionary* result, NSError *error);

@interface PublicService : NSObject

+ (PublicService *)sharedInstance;

- (void) getConfigurationOnCompletion:(getConfigurationCompletionHandler)completionHandler;
- (void) authenticate:(authenticateCompletionHandler)completionHandler;

@end
