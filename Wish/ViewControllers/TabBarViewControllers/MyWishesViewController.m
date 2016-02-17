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

@property (strong, nonatomic) IBOutlet UIView *sigInView;

@end

@implementation MyWishesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sigInView.hidden = YES;
    [self getWishes];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveGetRefreshNotification:)
                                                 name:@"getRefreshNotification"
                                               object:nil];
    
    self.pageIndex = MY_WISHES_PAGE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(UIRefreshControl *)sender{
        
    [self getWishes];
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
//        indicator.center =CGPointMake(kmainScreenWidth/2, kmainScreenHeight);
//        [transparent addSubview:indicator];
//        [indicator startAnimating];
//        [self.view addSubview:transparent];
        
        [[PrivateService sharedInstance] getMyWishesWIthUserID:appDelegate.configuration.myUserID OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
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
    
        [[PrivateService sharedInstance] getMyWishesWitLimit:self.wishesArray.count OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
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

- (IBAction)sigInButtonAction:(UIButton *)sender {
    
    [WishUtils openLoginPage];
}

@end
