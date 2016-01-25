//
//  GeneralService.h
//  AVTMobile
//
//  Created by Annie Klekchyan on 7/28/15.
//  Copyright (c) 2015 Annie Klekchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^getPinVerificationTypesCompletionHandler)(NSDictionary* result, NSError *error);

@interface GeneralService : NSObject

+ (GeneralService *)sharedInstance;
- (void)getPinVerificationTypes:(NSString *)phoneNumber onCompletion:(getPinVerificationTypesCompletionHandler)completionHandler;
@end
