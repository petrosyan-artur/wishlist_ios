//
//  WishUtils.h
//  Wish
//
//  Created by Annie Klekchyan on 1/22/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WishUtils : NSObject

+ (void) shakeAnimationWithViewComtroller:(UIViewController *) vController;
+ (void) configureTabBar;
+ (void) configureNavigationBar;
+ (void) showErrorAlert;
+ (void) showErrorAlertWithTitle:(NSString *) title AndText:(NSString *)text;

@end
