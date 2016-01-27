//
//  PublicService.m
//  Wish
//
//  Created by Annie Klekchyan on 1/18/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "PublicService.h"
#import "AFHTTPRequestOperationManager.h"
#import "WishUtils.h"

@implementation PublicService

static PublicService *sharedInstance = nil;
static NSString *publicURLString;
static AFHTTPRequestOperationManager *manager;

+ (PublicService *)sharedInstance {
    
    @synchronized(self) {
        if (sharedInstance == nil){
            sharedInstance = [[self alloc] init];
        }
    }
    
    NSString *platform = @"iOS";
    NSString *model = [[UIDevice currentDevice] model];
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *appVersion = [NSString stringWithFormat:@"Version %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    appVersion = [appVersion substringFromIndex:8];
    
    NSString *userAgentHeaderString = [NSString stringWithFormat:@"%@, %f, %@, %@", platform, osVersion, model, appVersion];
    
    publicURLString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SERVICE_URL_PUBLIC"];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:userAgentHeaderString forHTTPHeaderField:@"User-Agent"];
    return sharedInstance;
}

-(void) getConfigurationOnCompletion:(getConfigurationCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/configuration", publicURLString];

    [manager GET:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) getUserNameOnCompletion:(getUserNameCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/users", publicURLString];
    
    [manager GET:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) registerUserWithUserName:(NSString *)username Password:(NSString *)password Password2:(NSString *)password2 OnCompletion:(registerUserCompletionHandler)completionHandle{
    
    NSString *contString = [NSString stringWithFormat:@"%@/register", publicURLString];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"username",
                            password, @"password",
                            password2, @"password2",
                            nil];
    
    [manager POST:contString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandle(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) authenticate:(authenticateCompletionHandler)completionHandler{

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    NSString *contString = [NSString stringWithFormat:@"%@/users", publicURLString];
//    
//    [manager GET:confString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}

@end
