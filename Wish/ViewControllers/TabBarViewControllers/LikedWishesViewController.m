//
//  LikedWishesViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 1/25/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "LikedWishesViewController.h"
#import "PrivateService.h"

@interface LikedWishesViewController ()

@end

@implementation LikedWishesViewController{
    AppDelegate* appDelgate;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //self.wishesArray = [[NSMutableArray alloc] initWithArray:self.appDelgate.wishArray];
    [self getWishes];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(receiveGetRefreshNotification:)
//                                                 name:@"getRefreshNotification"
//                                               object:nil];
}

- (void)refresh:(UIRefreshControl *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self getWishes];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.refreshControl endRefreshing];
        });
    });
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
}

- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) receiveGetRefreshNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"getRefreshNotification"]){
        
        [self getWishes];
    }
}

- (void) getWishes{
    
    [self.wishesArray removeAllObjects];
    if ([WishUtils isAuthenticated]) {
        
        NSLog(@"%@", appDelgate.configuration.myUserID);
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        NSLog(@"%@", appDelegate.configuration.myUserID);
        [[PrivateService sharedInstance] getMyWishesWIthUserID:appDelegate.configuration.myUserID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
           
            self.wishesArray = [WishUtils updateWishArray:result];
            NSLog(@"qqqqqqqq = %@", result);
            [self.wishListTableView reloadData];
        }];
    }else{
        
    
    }
}

- (void) getMoreWishes{
    
//    if ([WishUtils isAuthenticated]) {
//        
//        [[PrivateService sharedInstance] getWishesWitLimit:self.appDelgate.wishArray.count OnCompletion:^(NSDictionary *result, BOOL isSucess) {
//            
//            if(isSucess){
//                
//                self.wishesArray = [WishUtils updatePrivateWishArray:result];
//                [self.wishListTableView reloadData];
//            }else{
//                
//            }
//        }];
//    }else{
//        
//        
//    }
}

@end
