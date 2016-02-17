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
static AppDelegate* appDelgate;

+(PrivateService *)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil){
            sharedInstance = [[self alloc] init];
            }
        }
    
    appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
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

- (void) getWishesOnCompletion:(getWishesCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes", privateURLString];
    
    [manager GET:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) postWishWithContent:(NSString *)content Color:(NSString *)color AndImage:(NSString *)imageURL OnCompletion:(postWishCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes", privateURLString];
    
    NSDictionary *colorDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    color, @"color",
                                    imageURL, @"image",
                                    nil];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            content, @"content",
                            colorDict, @"decoration",
                            nil];
    
    [manager POST:contString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) getWishesWithLimit:(NSInteger)limit OnCompletion:(getWishesWithLimitCompletionHandler)completionHandler{

    NSString *contString = [NSString stringWithFormat:@"%@/wishes", privateURLString];
    NSString *limitString = [NSString stringWithFormat:@"%d", limit];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                               limitString, @"limit",
                               nil];
    
    [manager GET:contString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) likeWishWithUserID:(NSString *)userID AndWishID:(NSString *) wishID OnCompletion:(likeWishesCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/rates", privateURLString];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            wishID, @"wishId",
                            userID, @"userId",
                            nil];
    
    [manager POST:contString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) dislikeWishWithUserID:(NSString *)userID AndWishID:(NSString *) wishID OnCompletion:(dislikeWishesCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/rates/%@/%@", privateURLString, userID, wishID];
    
    [manager DELETE:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) getMyWishesWIthUserID:(NSString *) userID OnCompletion:(getMyWishesCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes?userId=%@", privateURLString, userID];
    
    [manager GET:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) getMyWishesWitLimit:(NSInteger)limit OnCompletion:(getMyWishesWithLimitCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes?userId=%@", privateURLString, appDelgate.configuration.myUserID];
    NSString *limitString = [NSString stringWithFormat:@"%d", limit];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            limitString, @"limit",
                            nil];
    
    [manager GET:contString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) getMyLikesWIthUserID:(NSString *) userID OnCompletion:(getMyLikesCompletionHandler)completionHandler{
  
    NSString *contString = [NSString stringWithFormat:@"%@/wishes?userId=%@&liked=1", privateURLString, userID];
    
    [manager GET:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) getMyLikesWitLimit:(NSInteger)limit OnCompletion:(getMyLikesWithLimitCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes?userId=%@&liked=1", privateURLString, appDelgate.configuration.myUserID];
    NSString *limitString = [NSString stringWithFormat:@"%d", limit];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            limitString, @"limit",
                            nil];
    
    [manager GET:contString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) editWishWithWishObject:(WishObject *)wish OnCompletion:(editWishCompletionHandler)completionHandler{

    NSString *contString = [NSString stringWithFormat:@"%@/wishes", privateURLString];
    
    NSDictionary *colorDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               wish.decoration.colorString, @"color",
                               wish.decoration.imageURL, @"image",
                               nil];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            wish.wishID, @"_id",
                            wish.content, @"content",
                            colorDict, @"decoration",
                            nil];
    
    [manager PUT:contString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) deleteWishWithWishObject:(WishObject *)wish OnCompletion:(deleteWishCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes/%@?userId=%@", privateURLString, wish.wishID, appDelgate.configuration.myUserID];
    
    [manager DELETE:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) isNewWishesWithLastWishID:(NSString *)lastWishID OnCompletion:(isNewWishesCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes?count=1&wishId=%@", privateURLString, lastWishID];
    
    [manager GET:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) getWishesWithUserID:(NSString *)userID OnCompletion:(getWishesWithUserIDCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes?userId=%@", privateURLString, userID];
    
    [manager GET:contString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

- (void) getWishesWithLimit:(NSInteger)limit AndUserID:(NSString *)userID OnCompletion:(getOtherWishesWithLimitCompletionHandler)completionHandler{
    
    NSString *contString = [NSString stringWithFormat:@"%@/wishes?userId=%@", privateURLString,userID];
    NSString *limitString = [NSString stringWithFormat:@"%d", limit];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            limitString, @"limit",
                            nil];
    
    [manager GET:contString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        completionHandler(responseObject, [[responseObject objectForKey:@"success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [WishUtils showErrorAlert];
    }];
}

@end
