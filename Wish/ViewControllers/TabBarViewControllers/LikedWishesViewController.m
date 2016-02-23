//
//  LikedWishesViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 1/25/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "LikedWishesViewController.h"
#import "PrivateService.h"
#import "WishObject.h"

@interface LikedWishesViewController ()
@property (strong, nonatomic) IBOutlet UIView *sigInView;
@end

@implementation LikedWishesViewController{
    AppDelegate* appDelgate;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.sigInView.hidden = YES;
    [self getWishes];
    
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
    self.pageIndex = LIKES_PAGE;
}

- (void)refresh:(UIRefreshControl *)sender
{
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

- (void) receiveDislikeWishesNotification:(NSNotification *) notification{
        
    if ([[notification name] isEqualToString:@"dislikeWishesNotification"]){
        
        NSDictionary* userInfo = notification.userInfo;
   
        WishObject* wishObject = (WishObject *) userInfo[@"wishObject"];
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (WishObject *wish in self.wishesArray){
            
            if(wish.timestamp == wishObject.timestamp){
                
            }else{
                
                [temp addObject:wish];
            }
                
        }
        
        self.wishesArray = temp;
        
        [self.wishesArray sortUsingDescriptors:
         @[
           [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO],
           ]];
        
        [self.wishListTableView reloadData];
    }
}

- (void) receiveLikeWishesNotification:(NSNotification *) notification{
    
    if ([[notification name] isEqualToString:@"likeWishesNotification"]){
        
        NSDictionary* userInfo = notification.userInfo;
        WishObject* wishObject = (WishObject *) userInfo[@"wishObject"];
        
        BOOL isexist = NO;
        for (WishObject *wish in self.wishesArray){
            
            if(wish.timestamp == wishObject.timestamp){
                
                isexist = YES;
            }else{
            
            }
            
        }
        
        if(!isexist){
            
            [self.wishesArray addObject:wishObject];
        }
        
        [self.wishesArray sortUsingDescriptors:
         @[
           [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO],
           ]];
        
        [self.wishListTableView reloadData];
    }
}

- (void) receiveEditWishNotification:(NSNotification *) notification
{
    if(self.appDelgate.currentPageIndex != self.pageIndex){
        
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
}

- (void) receiveDeleteWishNotification:(NSNotification *) notification
{
    if(self.appDelgate.currentPageIndex != self.pageIndex){
        
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
}

- (void) getWishes{
    
    [self.wishesArray removeAllObjects];
    if ([WishUtils isAuthenticated]) {
        
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
//        UIView *transparent = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, kmainScreenWidth, kmainScreenHeight)];
//        transparent.backgroundColor = [UIColor blackColor];
//        transparent.alpha = 0.8f;
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        indicator.center =CGPointMake(kmainScreenWidth/2, kmainScreenHeight/2);
//        [transparent addSubview:indicator];
//        [indicator startAnimating];
//        [self.view addSubview:transparent];
        
        [[PrivateService sharedInstance] getMyLikesWIthUserID:appDelegate.configuration.myUserID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
//            [transparent removeFromSuperview];
            if(isSucess){
                self.sigInView.hidden = YES;
                self.wishesArray = [WishUtils updateWishArray:result];
                [self.wishListTableView reloadData];
                [self.refreshControl endRefreshing];
            }
        }];
        
    }else{
        
        self.sigInView.hidden = NO;
    }
}

- (void) getMoreWishes{
    
    if ([WishUtils isAuthenticated]) {
        
        [[PrivateService sharedInstance] getMyLikesWitLimit:self.wishesArray.count OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
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
        
        
    }
}

- (IBAction)signInButtonAction:(UIButton *)sender {
    
    [WishUtils openLoginPage];
}

@end
