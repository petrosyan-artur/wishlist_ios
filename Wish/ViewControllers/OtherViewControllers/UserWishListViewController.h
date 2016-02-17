//
//  UserWishListViewController.h
//  Wish
//
//  Created by Annie Klekchyan on 2/17/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WishObject.h"

@interface UserWishListViewController : BaseViewController

@property (nonatomic, strong) WishObject *wish;

@end
