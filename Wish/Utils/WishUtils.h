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
+ (UIColor *)getColorFromString:(NSString *)colorString;
+ (BOOL) isEqualFisrtColor:(UIColor *) firstColor AndSecondColor:(UIColor *) secondColor;
+ (NSString *)setRightDateFormat:(NSDate *) compareDate;
+ (BOOL)isToday:(NSDate *)compareDate;
+ (NSDate *)getDateFromString:(NSString *) dateString;
+ (void) getWishes;
+ (UIViewController*) getTopMostViewController;
+ (BOOL) isAuthenticated;
+ (void) openLoginPage;
+ (NSMutableArray *) updatePrivateWishArray:(NSDictionary *) result;
+ (NSMutableArray *) updatePublicWishArray:(NSDictionary *) result;
+ (NSMutableArray *) updateWishArray:(NSDictionary *) result;
+ (NSMutableArray *) updateWishArray:(NSDictionary *) result AndCurrentWishArray:(NSMutableArray *)currentArray;
+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius;

@end
