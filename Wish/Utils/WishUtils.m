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
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

+ (void) showErrorAlert{

    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"Something went wrong, please try again."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                }];
    
    [alert addAction:yesButton];
    
    UIViewController *top = [self getTopMostViewController];
    [top presentViewController:alert animated:YES completion:nil];
}

+ (void) showErrorAlertWithTitle:(NSString *) title AndText:(NSString *)text{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:text
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                }];
    
    [alert addAction:yesButton];
    
    UIViewController *top = [self getTopMostViewController];
    [top presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController*) getTopMostViewController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    for (UIView *subView in [window subviews])
    {
        UIResponder *responder = [subView nextResponder];
        
        //added this block of code for iOS 8 which puts a UITransitionView in between the UIWindow and the UILayoutContainerView
        if ([responder isEqual:window])
        {
            //this is a UITransitionView
            if ([[subView subviews] count])
            {
                UIView *subSubView = [subView subviews][0]; //this should be the UILayoutContainerView
                responder = [subSubView nextResponder];
            }
        }
        
        if([responder isKindOfClass:[UIViewController class]]) {
            return [self topViewController: (UIViewController *) responder];
        }
    }
    
    return nil;
}

+ (UIViewController *) topViewController: (UIViewController *) controller
{
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
        
    } while (isPresenting);
    
    return controller;
}

+ (UIColor *)getColorFromString:(NSString *)colorString{
    
    NSArray *colorValueArray = [colorString componentsSeparatedByString:@","];
    
    int rValue = [[colorValueArray objectAtIndex:0] intValue];
    int gValue = [[colorValueArray objectAtIndex:1] intValue];
    int bValue = [[colorValueArray objectAtIndex:2] intValue];
    
    UIColor *color = [UIColor colorWithRed:rValue/255.0f green:gValue/255.0f blue:bValue/255.0f alpha:1];
    return color;
}

+ (BOOL) isEqualFisrtColor:(UIColor *) firstColor AndSecondColor:(UIColor *) secondColor
{
    return CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor);
}

@end
