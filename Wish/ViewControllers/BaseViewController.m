//
//  BaseViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 2/9/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController{
    
    AppDelegate* appDelgate;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.wishListTableView.estimatedRowHeight = 200.0f;
    self.wishListTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
