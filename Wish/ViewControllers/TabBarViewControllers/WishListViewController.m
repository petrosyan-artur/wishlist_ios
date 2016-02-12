//
//  WishListViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 1/25/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "WishListViewController.h"
#import "AppDelegate.h"
#import "WishTableViewCell.h"
#import "WishObject.h"
#import "WishUtils.h"
#import "Definitions.h"
#import "PrivateService.h"
#import "PublicService.h"

@interface WishListViewController ()

@end

@implementation WishListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.wishesArray = [[NSMutableArray alloc] initWithArray:self.appDelgate.wishArray];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveGetRefreshNotification:)
                                                 name:@"getRefreshNotification"
                                               object:nil];
}

- (void)refresh:(UIRefreshControl *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self getWishes];
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.refreshControl endRefreshing];;
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
    self.appDelgate.wishArray = [[NSMutableArray alloc] init];
    if ([WishUtils isAuthenticated]) {
        
        [[PrivateService sharedInstance] getWishesOnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                self.wishesArray = [WishUtils updatePrivateWishArray:result];
                [self.wishListTableView reloadData];
            }else{
                
            }
        }];
    }else{
        
        [[PublicService sharedInstance] getWishesOnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                self.wishesArray = [WishUtils updatePublicWishArray:result];
                [self.wishListTableView reloadData];
            }else{
                
            }
        }];
    }
}

- (void) getMoreWishes{
    
    if ([WishUtils isAuthenticated]) {
        
        [[PrivateService sharedInstance] getWishesWitLimit:self.appDelgate.wishArray.count OnCompletion:^(NSDictionary *result, BOOL isSucess) {
           
            if(isSucess){
                
                NSArray *wishes = [result objectForKey:@"wishes"];
                if(wishes.count > 0){
                    self.wishesArray = [WishUtils updatePrivateWishArray:result];
                    [self.wishListTableView reloadData];
                }
            }else{
                
            }
        }];
    }else{
        
        [[PublicService sharedInstance] getWishesOnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                NSArray *wishes = [result objectForKey:@"wishes"];
                if(wishes.count > 0){
                    self.wishesArray = [WishUtils updatePublicWishArray:result];
                    [self.wishListTableView reloadData];
                }
            }else{
                
            }
        }];
    }
}

@end
