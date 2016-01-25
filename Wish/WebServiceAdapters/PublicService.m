//
//  PublicService.m
//  Wish
//
//  Created by Annie Klekchyan on 1/18/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "PublicService.h"
#import "AFHTTPRequestOperationManager.h"

@implementation PublicService

static PublicService *sharedInstance = nil;

+ (PublicService *)sharedInstance {
    
    @synchronized(self) {
        if (sharedInstance == nil){
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

-(void) getConfigurationOnCompletion:(getConfigurationCompletionHandler)completionHandler{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *confString = [NSString stringWithFormat:@"http://37.48.84.64:201/api/v1/configuration"];

    [manager GET:confString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
