//
//  PrivateService.m
//  AVTMobile
//
//  Created by Annie Klekchyan on 7/16/15.
//  Copyright (c) 2015 Annie Klekchyan. All rights reserved.
//

#import "PrivateService.h"
#import "AFNetworking.h"

@implementation PrivateService

static PrivateService *sharedInstance = nil;
static NSString *BaseURLString;

+(PrivateService *)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil){
            sharedInstance = [[self alloc] init];
            }
        }
    return sharedInstance;
}


@end
