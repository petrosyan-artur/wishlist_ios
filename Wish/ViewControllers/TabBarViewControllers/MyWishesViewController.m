//
//  MyWishesViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 1/25/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "MyWishesViewController.h"
#import "PrivateService.h"

@interface MyWishesViewController ()

@end

@implementation MyWishesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getWishes];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveGetRefreshNotification:)
                                                 name:@"getRefreshNotification"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) receiveGetRefreshNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"getRefreshNotification"]){
        
        [self getWishes];
    }
}

- (void) getWishes{
    
    [self.wishesArray removeAllObjects];
    if ([WishUtils isAuthenticated]) {
        
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [[PrivateService sharedInstance] getMyWishesWIthUserID:appDelegate.configuration.myUserID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            self.wishesArray = [WishUtils updateWishArray:result];
            [self.wishListTableView reloadData];
        }];
    }else{
        
        
    }
}

- (void) getMoreWishes{
    
    if ([WishUtils isAuthenticated]) {
        
        [[PrivateService sharedInstance] getMyWishesWitLimit:self.wishesArray.count OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                NSArray *wishes = [result objectForKey:@"wishes"];
                NSLog(@"qqqqqqq = %@", wishes);
                if(wishes.count > 0){
                    self.wishesArray = [WishUtils updateWishArray:result AndCurrentWishArray:self.wishesArray];
                    [self.wishListTableView reloadData];
                }
            }else{
                
            }
        }];
    }else{
        
        
    }
}

@end
