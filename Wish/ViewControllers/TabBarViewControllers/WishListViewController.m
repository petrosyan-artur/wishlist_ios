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

@interface WishListViewController (){
    NSTimer *newWishesTimer;
}

@property (strong, nonatomic) IBOutlet UIButton *showNewWishesButton;
- (IBAction)showNewWishesButtonAction:(UIButton *)sender;

@end

@implementation WishListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.wishesArray = [[NSMutableArray alloc] initWithArray:self.appDelgate.wishArray];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveGetRefreshNotification:)
                                                 name:@"getRefreshNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveLikeWishesNotification:)
                                                 name:@"likeWishesNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDislikeWishesNotification:)
                                                 name:@"dislikeWishesNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveEditWishNotification:)
                                                 name:@"editWishNotification"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeleteWishNotification:)
                                                 name:@"deleteWishNotification"
                                               object:nil];
    
    
    self.pageIndex = HOME_PAGE;
    
    self.showNewWishesButton.layer.cornerRadius = 20.0;
    [self.showNewWishesButton.layer setMasksToBounds:YES];
    self.showNewWishesButton.hidden = YES;
    NSTimeInterval interval = self.appDelgate.webConfiguration.wishCheckInterval;
    newWishesTimer = [NSTimer scheduledTimerWithTimeInterval: interval
                                                      target: self
                                                    selector:@selector(newWishesTimerTick:)
                                                    userInfo: nil repeats:YES];
    
}

- (void) receiveDislikeWishesNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"dislikeWishesNotification"]){
        
        NSDictionary* userInfo = notification.userInfo;
        WishObject* wishObject = (WishObject *) userInfo[@"wishObject"];
        int i = 0;
        for (WishObject *wish in self.wishesArray){
            
            if(wish.timestamp == wishObject.timestamp){
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
                [self.wishesArray replaceObjectAtIndex:i withObject:wishObject];
                [self.wishListTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                break;
            }else{
                
             
            }
            i++;
        }
    }
}

- (void) receiveLikeWishesNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"likeWishesNotification"]){
        
        
        NSDictionary* userInfo = notification.userInfo;
        WishObject* wishObject = (WishObject *) userInfo[@"wishObject"];
        int i = 0;
        for (WishObject *wish in self.wishesArray){
            
            if(wish.timestamp == wishObject.timestamp){
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
                [self.wishesArray replaceObjectAtIndex:i withObject:wishObject];
                [self.wishListTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                break;
            }else{
                
                
            }
            i++;
        }
    }
}

- (void) receiveEditWishNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"editWishNotification"]){
        
        NSDictionary* userInfo = notification.userInfo;
        WishObject* wishObject = (WishObject *) userInfo[@"wishObject"];
        int i = 0;
        for (WishObject *wish in self.wishesArray){
            
            if(wish.timestamp == wishObject.timestamp){
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
                [self.wishesArray replaceObjectAtIndex:i withObject:wishObject];
                [self.wishListTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                break;
            }else{
                
                
            }
            i++;
        }
    }
}

- (void) receiveDeleteWishNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"deleteWishNotification"]){
        
        NSDictionary* userInfo = notification.userInfo;
        WishObject* wishObject = (WishObject *) userInfo[@"wishObject"];
        int i = 0;
        for (WishObject *wish in self.wishesArray){
            
            if(wish.timestamp == wishObject.timestamp){
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
                [self.wishesArray replaceObjectAtIndex:i withObject:wishObject];
                
                [self.wishesArray removeObjectAtIndex:i];
                [self.wishListTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                break;
            }else{
                
                
            }
            i++;
        }
    }
}

- (IBAction)newWishesTimerTick:(NSTimer *)sender{
    
    if(self.wishesArray.count > 0){
        
        WishObject *lastWishObject = [self.wishesArray objectAtIndex:0];
        NSString *lastWishID = lastWishObject.wishID;
        
        if([WishUtils isAuthenticated]){
            
            [[PrivateService sharedInstance] isNewWishesWithLastWishID:lastWishID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
                
                if(isSucess){
                    
                    BOOL hasNewWish = [[result objectForKey:@"hasNew"] boolValue];
                    if(hasNewWish){
                        
                        self.showNewWishesButton.hidden = NO;
                    }else{
                        
                        self.showNewWishesButton.hidden = YES;
                    }
                }else{
                    
                }
            }];
        }else{
            
            [[PublicService sharedInstance] isNewWishesWithLastWishID:lastWishID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
                
                if(isSucess){
                    
                    BOOL hasNewWish = [[result objectForKey:@"hasNew"] boolValue];
                    if(hasNewWish){
                        
                        self.showNewWishesButton.hidden = NO;
                    }else{
                        
                        self.showNewWishesButton.hidden = YES;
                    }
                }else{
                    
                }
            }];
        }
    }
}

- (void)refresh:(UIRefreshControl *)sender{
    
    [self getWishes];
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
        
        //[self getWishes];
        self.showNewWishesButton.hidden = NO;
    }
}

- (void) getWishes{

    [self.wishesArray removeAllObjects];
    self.appDelgate.wishArray = [[NSMutableArray alloc] init];
    
//    UIView *transparent = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, kmainScreenWidth, kmainScreenHeight)];
//    transparent.backgroundColor = [UIColor blackColor];
//    transparent.alpha = 0.8f;
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicator.center =CGPointMake(kmainScreenWidth/2, kmainScreenHeight/2);
//    [transparent addSubview:indicator];
//    [indicator startAnimating];
//    [self.view addSubview:transparent];
    
    if ([WishUtils isAuthenticated]) {
        
        [[PrivateService sharedInstance] getWishesOnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
//            [transparent removeFromSuperview];
            if(isSucess){
                
                self.wishesArray = [WishUtils updatePrivateWishArray:result];
                [self.refreshControl endRefreshing];
                [self.wishListTableView reloadData];
                NSIndexPath *topPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.wishListTableView scrollToRowAtIndexPath:topPath
                                 atScrollPosition:UITableViewScrollPositionTop
                                         animated:YES];
            }else{
                
            }
        }];
    }else{
        
        [[PublicService sharedInstance] getWishesOnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
//            [transparent removeFromSuperview];
            if(isSucess){
                
                self.wishesArray = [WishUtils updatePublicWishArray:result];
                [self.refreshControl endRefreshing];
                [self.wishListTableView reloadData];
                NSIndexPath *topPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.wishListTableView scrollToRowAtIndexPath:topPath
                                              atScrollPosition:UITableViewScrollPositionTop
                                                      animated:YES];
            }else{
                
            }
        }];
    }
}

- (void) getMoreWishes{
    
    if ([WishUtils isAuthenticated]) {
        
        [[PrivateService sharedInstance] getWishesWithLimit:self.appDelgate.wishArray.count OnCompletion:^(NSDictionary *result, BOOL isSucess) {
           
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
        
        [[PublicService sharedInstance] getWishesWithLimit:self.appDelgate.wishArray.count OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
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

- (IBAction)showNewWishesButtonAction:(UIButton *)sender {
    
    [self getWishes];
    sender.hidden = YES;
}
@end
