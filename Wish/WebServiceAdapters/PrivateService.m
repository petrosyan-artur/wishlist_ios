//
//  PrivateService.m
//  AVTMobile
//
//  Created by Annie Klekchyan on 7/16/15.
//  Copyright (c) 2015 Annie Klekchyan. All rights reserved.
//

#import "PrivateService.h"
#import "AFNetworking.h"
#import "WishUtils.h"
#import "Definitions.h"

@implementation PrivateService

static PrivateService *sharedInstance = nil;
static NSString *privateURLString;
static AFHTTPRequestOperationManager *manager;

+(PrivateService *)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil){
            sharedInstance = [[self alloc] init];
            }
        }
    
    AppDelegate* appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *platform = @"iOS";
    NSString *model = [[UIDevice currentDevice] model];
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *appVersion = [NSString stringWithFormat:@"Version %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    appVersion = [appVersion substringFromIndex:8];
    
    NSString *userAgentHeaderString = [NSString stringWithFormat:@"%@, %f, %@, %@", platform, osVersion, model, appVersion];
    
    privateURLString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SERVICE_URL_PRIVATE"];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:userAgentHeaderString forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:appDelgate.configuration.token forHTTPHeaderField:@"x-access-token"];
    return sharedInstance;
}

-(void) getWishesOnCompletion:(getWishesCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes", privateURLString];
    
    [manager GET:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

@end
