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

@interface BaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *wishListTableView;
@property (strong, nonatomic) NSMutableArray *wishesArray;
- (void) getMoreWishes;

@end