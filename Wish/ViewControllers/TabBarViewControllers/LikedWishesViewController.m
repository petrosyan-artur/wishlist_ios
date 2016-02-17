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
                                             selector:@selector(receiveGetRefreshNotification:)
                                                 name:@"getRefreshNotification"
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
