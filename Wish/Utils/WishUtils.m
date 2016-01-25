//
//  WishUtils.m
//  Wish
//
//  Created by Annie Klekchyan on 1/22/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "WishUtils.h"

@implementation WishUtils

+ (void) shakeAnimationWithViewComtroller:(UIViewController *) vController{
    
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:4];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([vController.view center].x - 20.0f, [vController.view center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([vController.view center].x + 20.0f, [vController.view center].y)]];
    [[vController.view layer] addAnimation:animation forKey:@"position"];
}

+ (void) configureTabBar{
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }
                                             forState:UIControlStateSelected];
    
    UIColor *navColor = [UIColor colorWithRed:92/255.0 green:148/255.0 blue:185/255.0 alpha:1];
    [[UITabBar appearance] setBarTintColor:navColor];
}

+ (void) configureNavigationBar{
    
    UIColor *navColor = [UIColor colorWithRed:0/255.0 green:110/255.0 blue:145/255.0 alpha:1];
    [[UINavigationBar appearance] setBarTintColor:navColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setBarTintColor:navColor];
}

@end
