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

@interface WishListViewController ()

@end

@implementation WishListViewController{
    AppDelegate* appDelgate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveGetWishesNotification:)
                                                 name:@"getWishesNotification"
                                               object:nil];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [WishUtils getWishes];
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
    
    cell.likesCountLabel.text = [NSString stringWithFormat:@"%d", wish.likesCount];
    [cell setLikeLabelWithCount:wish.likesCount];
    
    [cell setLikeButtonState:wish.amILike];
    
    if (indexPath.row == [appDelgate.wishArray count] - 1)
    {
       // [self launchReload];
    }
    
    return cell;
}

@end
