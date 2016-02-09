//
//  MainTabBarController.m
//  Wish
//
//  Created by Annie Klekchyan on 1/18/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "MainTabBarController.h"
#import "CreateWishViewController.h"
#import "AppDelegate.h"
#import "SignUpViewController.h"
#import "WishUtils.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    CGSize tabBarSize = self.tabBar.bounds.size;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 80, tabBarSize.height);
    button.center = self.tabBar.center;
    button.titleLabel.font = [UIFont systemFontOfSize:21.0f];
    [button setTitle:@"WISH" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:0/255.0 green:110/255.0 blue:145/255.0 alpha:1]];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(openNewWish:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openNewWish:(UIButton *)sender{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *createWishNavigationViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateWishNavigationController"];
    
    if([WishUtils isAuthenticated]){
        
        CreateWishViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateWishViewController"];
        createWishNavigationViewController.viewControllers = @[rootViewController];
    }else{
        
        SignUpViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
        createWishNavigationViewController.viewControllers = @[rootViewController];
    }
    [self.navigationController showDetailViewController:createWishNavigationViewController sender:self];
}

@end
