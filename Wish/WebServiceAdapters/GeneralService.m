//
//  GeneralService.m
//  AVTMobile
//
//  Created by Annie Klekchyan on 7/28/15.
//  Copyright (c) 2015 Annie Klekchyan. All rights reserved.
//

#import "GeneralService.h"
#import "AFNetworking.h"

@implementation GeneralService

static GeneralService *sharedInstance = nil;

+(GeneralService *)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil){
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (void)getPinVerificationTypes:(NSString *)phoneNumber onCompletion:(getPinVerificationTypesCompletionHandler)completionHandler
{

    
}

@end
