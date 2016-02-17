//
//  BaseViewController.h
//  Wish
//
//  Created by Annie Klekchyan on 2/9/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WishTableViewCell.h"
#import "WishObject.h"
#import "WishUtils.h"

@interface BaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, WishTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *wishListTableView;
@property (strong, nonatomic) NSMutableArray *wishesArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) AppDelegate* appDelgate;
@property (assign, nonatomic) PageIndex pageIndex;

- (void) getMoreWishes;

@end
