//
//  BaseViewController.m
//  Wish
//
//  Created by Annie Klekchyan on 2/9/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "BaseViewController.h"
#import "PrivateService.h"
#import "EditWishViewController.h"
#import "PrivateService.h"

@interface BaseViewController ()

@end

@implementation BaseViewController{
    
    
}
@synthesize refreshControl, appDelgate;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.wishListTableView.estimatedRowHeight = 200.0f;
    self.wishListTableView.rowHeight = UITableViewAutomaticDimension;
    self.wishListTableView.delaysContentTouches = NO;
    self.wishesArray = [[NSMutableArray alloc] init];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.wishListTableView addSubview:refreshControl];
}

- (void)refresh:(UIRefreshControl *)sender{
    
}

- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wishesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"WishTableViewCell";
    WishObject *wish = [self.wishesArray objectAtIndex:indexPath.row];
    
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
    cell.wish = wish;
    cell.pageIndex = self.pageIndex;
    cell.delegate = self;
    if (indexPath.row == [self.wishesArray count] - 1)
    {
        [self getMoreWishes];
    }
    
    return cell;
}

- (IBAction)likeButtonAction:(UIButton *)sender{
    
    if([WishUtils isAuthenticated]){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
        WishObject *wish = [self.wishesArray objectAtIndex:indexPath.row];
        
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
    
}

#pragma mark - LongPressMenuDelegate

- (void) editWishWithWishObject:(WishObject *)wish{
    
    if(wish.likesCount == 0){
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController *editWishNavigationViewController = [storyboard instantiateViewControllerWithIdentifier:@"EditWishNavigationController"];
        
        if([WishUtils isAuthenticated]){
            
            EditWishViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"EditWishViewController"];
            rootViewController.wish = wish;
            editWishNavigationViewController.viewControllers = @[rootViewController];
        }else{
            
        }
        
        [self.navigationController showDetailViewController:editWishNavigationViewController sender:self];
        
    }else{
        [WishUtils showErrorAlertWithTitle:@"" AndText:appDelgate.webConfiguration.wishEditAlertMessage];
    }
}

- (void) deleteWishWithWishObject:(WishObject *)wish{
    
    if(wish.likesCount == 0){
        
        [[PrivateService sharedInstance] deleteWishWithWishObject:wish OnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getRefreshNotification" object:self];
            }else{
                
                [WishUtils showErrorAlertWithTitle:@"" AndText:[result objectForKey:@"message"]];
            }
        }];
    }else{
        [WishUtils showErrorAlertWithTitle:@"" AndText:appDelgate.webConfiguration.wishDeleteAlertMessage];
    }
}

@end
