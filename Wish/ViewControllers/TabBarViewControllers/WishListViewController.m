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

@implementation WishListViewController{
    AppDelegate* appDelgate;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveGetWishesNotification:)
                                                 name:@"getWishesNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveGetRefreshNotification:)
                                                 name:@"getRefreshNotification"
                                               object:nil];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.wishListTableView addSubview:refreshControl];
}

- (void)refresh:(UIRefreshControl *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [WishUtils getWishes];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.wishListTableView reloadData];
            [refreshControl endRefreshing];;
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

- (void) receiveGetWishesNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"getWishesNotification"]){
        [self.wishListTableView reloadData];
    }
}

- (void) receiveGetRefreshNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"getRefreshNotification"]){
        [WishUtils getWishes];
        [self.wishListTableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appDelgate.wishArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"WishTableViewCell";
    WishObject *wish = [appDelgate.wishArray objectAtIndex:indexPath.row];
    
    WishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[WishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.usernameLabel.text = wish.userName;
    NSString *wishDateString = [WishUtils setRightDateFormat:wish.creationDate];
    cell.creationDateLabel.text = wishDateString;
    cell.contentLabel.text = wish.content;
    UIColor *bgColor = [WishUtils getColorFromString:wish.decoration.colorString];
    [cell.contView setBackgroundColor:bgColor];
    [cell.likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.likeButton.tag = indexPath.row;
    [cell setLikeLabelWithCount:wish.likesCount];
    
    [cell setLikeButtonState:wish.amILike];
    
    if (indexPath.row == [appDelgate.wishArray count] - 1)
    {
        [self getMoreWishes];
    }
    
    return cell;
}

- (IBAction)likeButtonAction:(UIButton *)sender{

    if([WishUtils isAuthenticated]){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
        WishObject *wish = [appDelgate.wishArray objectAtIndex:indexPath.row];
        
        if(wish.amILike){
            
            wish.amILike = NO;
            wish.likesCount --;
            NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
            [self.wishListTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            
            [[PrivateService sharedInstance] dislikeWishWithUserID:appDelgate.configuration.myUserID AndWishID:wish.wishID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
                
                if (isSucess) {
                    
                }else{
                    
                    wish.amILike = YES;
                    wish.likesCount ++;
                    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
                    [self.wishListTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                }
                
            }];
            
        }else{
            
            wish.amILike = YES;
            wish.likesCount ++;
            NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
            [self.wishListTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            
            [[PrivateService sharedInstance] likeWishWithUserID:appDelgate.configuration.myUserID AndWishID:wish.wishID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
                
                if(isSucess){
                    
                    
                }else{
                    
                    wish.amILike = NO;
                    wish.likesCount --;
                    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
                    [self.wishListTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                }
            }];
        }
    }else{
        
        [WishUtils openLoginPage];
    }
}

- (void) getMoreWishes{
    
    if ([WishUtils isAuthenticated]) {
        
        [[PrivateService sharedInstance] getWishesWitLimit:appDelgate.wishArray.count OnCompletion:^(NSDictionary *result, BOOL isSucess) {
           
            if(isSucess){
                
                [WishUtils updatePrivateWishArray:result];
            }else{
                
            }
        }];
    }else{
        
        [[PublicService sharedInstance] getWishesOnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                [WishUtils updatePublicWishArray:result];
            }else{
                
            }
        }];
    }
}

@end
