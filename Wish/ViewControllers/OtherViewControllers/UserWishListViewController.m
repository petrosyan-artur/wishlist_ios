//
//  UserWishListViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 2/17/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "UserWishListViewController.h"
#import "PrivateService.h"
#import "PublicService.h"

@interface UserWishListViewController ()

@end

@implementation UserWishListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.wish.userName;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backButton setImage:[UIImage imageNamed:@"backButtonIcon"] forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    [self getWishes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refresh:(UIRefreshControl *)sender
{
    [self getWishes];
}

- (void) getWishes{
    
    [self.wishesArray removeAllObjects];
    
//    UIView *transparent = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, kmainScreenWidth, kmainScreenHeight)];
//    transparent.backgroundColor = [UIColor blackColor];
//    transparent.alpha = 0.8f;
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicator.center =CGPointMake(kmainScreenWidth/2, kmainScreenHeight);
//    [transparent addSubview:indicator];
//    [indicator startAnimating];
//    [self.view addSubview:transparent];
    
    if ([WishUtils isAuthenticated]) {
        
        [[PrivateService sharedInstance] getWishesWithUserID:self.wish.userID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
//            [transparent removeFromSuperview];
            if(isSucess){
                
                self.wishesArray = [WishUtils updateWishArray:result];
                [self.wishListTableView reloadData];
                [self.refreshControl endRefreshing];
            }
        }];
    }else{
        
        [[PublicService sharedInstance] getWishesWIthUserID:self.wish.userID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
//            [transparent removeFromSuperview];
            if(isSucess){
                
                self.wishesArray = [WishUtils updateWishArray:result];
                [self.wishListTableView reloadData];
                [self.refreshControl endRefreshing];
            }
        }];
    }
}


- (void) getMoreWishes{
    
    if ([WishUtils isAuthenticated]) {
        
        [[PrivateService sharedInstance] getWishesWithLimit:self.wishesArray.count AndUserID:self.wish.userID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                NSArray *wishes = [result objectForKey:@"wishes"];
                if(wishes.count > 0){
                    self.wishesArray = [WishUtils updateWishArray:result AndCurrentWishArray:self.wishesArray];
                    [self.wishListTableView reloadData];
                }
            }else{
                
            }
        }];
    }else{
        
        [[PublicService sharedInstance] getWishesWithLimit:self.wishesArray.count AndUserID:self.wish.userID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                NSArray *wishes = [result objectForKey:@"wishes"];
                if(wishes.count > 0){
                    self.wishesArray = [WishUtils updateWishArray:result AndCurrentWishArray:self.wishesArray];
                    [self.wishListTableView reloadData];
                }
            }else{
                
            }
        }];
    }
}

@end
