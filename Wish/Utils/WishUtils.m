//
//  WishUtils.m
//  Wish
//
//  Created by Annie Klekchyan on 1/22/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "WishUtils.h"
#import "PublicService.h"
#import "PrivateService.h"
#import "WishObject.h"
#import "AppDelegate.h"
#import "SignUpViewController.h"

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
    //[[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }
    //                                         forState:UIControlStateSelected];
    
    UIColor *navColor = [UIColor colorWithRed:92/255.0 green:148/255.0 blue:185/255.0 alpha:1];
    [[UITabBar appearance] setBarTintColor:navColor];
    
    // set the selected icon color
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    // remove the shadow
    [[UITabBar appearance] setShadowImage:nil];
    
    // Set the dark color to selected tab (the dimmed background)
    [[UITabBar appearance] setSelectionIndicatorImage:[WishUtils imageFromColor:[UIColor colorWithRed:47/255.0 green:74/255.0 blue:96/255.0 alpha:1] forSize:CGSizeMake(64, 49) withCornerRadius:0]];
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

+ (NSString *)setRightDateFormat:(NSDate *) compareDate
{
    BOOL isToday = [self isToday:compareDate];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSString *dateString;
    if(isToday){
        
        [dateFormat setDateFormat:@"HH:mm"];
        dateString = [dateFormat stringFromDate:compareDate];
    }
    else{
        
        [dateFormat setDateFormat:@"dd MMM yyyy"];
        dateString = [dateFormat stringFromDate:compareDate];
    }
    
    return dateString;
}

+ (BOOL)isToday:(NSDate *)compareDate
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:compareDate];
    
    NSDate *smsDate = [cal dateFromComponents:components];
    
    if([today isEqualToDate:smsDate])
        return YES;
    else
        return NO;
}

+ (NSDate *)getDateFromString:(NSString *) dateString {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    return dateFromString;
}

+ (void) getWishes{
    
    AppDelegate* appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelgate.wishArray = [[NSMutableArray alloc] init];
   // [appDelgate.wishArray removeAllObjects];
    if ([self isAuthenticated]) {
        
        [[PrivateService sharedInstance] getWishesOnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                [self updatePrivateWishArray:result];
            }else{
                
            }
        }];
    }else{
        
        [[PublicService sharedInstance] getWishesOnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                [self updatePublicWishArray:result];
            }else{
                
            }
        }];
    }
}

+ (BOOL) isAuthenticated {
    
    AppDelegate* appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if(appDelgate.configuration.token && ![appDelgate.configuration.token isEqualToString:@""]){
        return YES;
    }else{
        return NO;
    }
}

+ (void) openLoginPage{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *createWishNavigationViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateWishNavigationController"];
    SignUpViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    createWishNavigationViewController.viewControllers = @[rootViewController];
    UIViewController *top = [WishUtils getTopMostViewController];
    [top showDetailViewController:createWishNavigationViewController sender:self];
}

+ (NSMutableArray *) updatePrivateWishArray:(NSDictionary *) result{
   
    AppDelegate* appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    for (NSDictionary *wishDict in [result objectForKey:@"wishes"]) {
        
        WishObject *wish = [[WishObject alloc] init];
        wish.wishID = [wishDict objectForKey:@"_id"];
        wish.content = [wishDict objectForKey:@"content"];
        wish.creationDate = [WishUtils getDateFromString:[wishDict objectForKey:@"createdDate"]];
        NSDictionary *decorationDict = [wishDict objectForKey:@"decoration"];
        wish.decoration.colorString = [decorationDict valueForKey:@"color"];
        wish.decoration.imageURL = [decorationDict objectForKey:@"image"];
        wish.isActive = [[wishDict objectForKey:@"isActive"] boolValue];
        wish.amILike = [[wishDict objectForKey:@"liked"] boolValue];
        wish.likesCount = [[wishDict objectForKey:@"likes"] intValue];
        wish.userID = [wishDict objectForKey:@"userId"];
        wish.userName = [wishDict objectForKey:@"username"];
        wish.timestamp = [[wishDict objectForKey:@"timestamp"] intValue];
        
        [appDelgate.wishArray addObject:wish];
    }
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"getWishesNotification" object:self];
    return appDelgate.wishArray;
}

+ (NSMutableArray *) updatePublicWishArray:(NSDictionary *) result{
    
    AppDelegate* appDelgate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    for (NSDictionary *wishDict in [result objectForKey:@"wishes"]) {
        
        WishObject *wish = [[WishObject alloc] init];
        wish.wishID = [wishDict objectForKey:@"_id"];
        wish.content = [wishDict objectForKey:@"content"];
        wish.creationDate = [WishUtils getDateFromString:[wishDict objectForKey:@"createdDate"]];
        NSDictionary *decorationDict = [wishDict objectForKey:@"decoration"];
        wish.decoration.colorString = [decorationDict valueForKey:@"color"];
        wish.decoration.imageURL = [decorationDict objectForKey:@"image"];
        wish.isActive = [[wishDict objectForKey:@"isActive"] boolValue];
        wish.likesCount = [[wishDict objectForKey:@"likes"] intValue];
        wish.userID = [wishDict objectForKey:@"userId"];
        wish.userName = [wishDict objectForKey:@"username"];
        wish.timestamp = [[wishDict objectForKey:@"timestamp"] intValue];
        
        [appDelgate.wishArray addObject:wish];
    }
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"getWishesNotification" object:self];
    return appDelgate.wishArray;
}

+ (NSMutableArray *) updateWishArray:(NSDictionary *) result AndCurrentWishArray:(NSMutableArray *)currentArray{
    
    for (NSDictionary *wishDict in [result objectForKey:@"wishes"]) {
        
        WishObject *wish = [[WishObject alloc] init];
        wish.wishID = [wishDict objectForKey:@"_id"];
        wish.content = [wishDict objectForKey:@"content"];
        wish.creationDate = [WishUtils getDateFromString:[wishDict objectForKey:@"createdDate"]];
        NSDictionary *decorationDict = [wishDict objectForKey:@"decoration"];
        wish.decoration.colorString = [decorationDict valueForKey:@"color"];
        wish.decoration.imageURL = [decorationDict objectForKey:@"image"];
        wish.isActive = [[wishDict objectForKey:@"isActive"] boolValue];
        wish.amILike = [[wishDict objectForKey:@"liked"] boolValue];
        wish.likesCount = [[wishDict objectForKey:@"likes"] intValue];
        wish.userID = [wishDict objectForKey:@"userId"];
        wish.userName = [wishDict objectForKey:@"username"];
        wish.timestamp = [[wishDict objectForKey:@"timestamp"] intValue];
        
        [currentArray addObject:wish];
    }
    return currentArray;
}

+ (NSMutableArray *) updateWishArray:(NSDictionary *) result{
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *wishDict in [result objectForKey:@"wishes"]) {
        
        WishObject *wish = [[WishObject alloc] init];
        wish.wishID = [wishDict objectForKey:@"_id"];
        wish.content = [wishDict objectForKey:@"content"];
        wish.creationDate = [WishUtils getDateFromString:[wishDict objectForKey:@"createdDate"]];
        NSDictionary *decorationDict = [wishDict objectForKey:@"decoration"];
        wish.decoration.colorString = [decorationDict valueForKey:@"color"];
        wish.decoration.imageURL = [decorationDict objectForKey:@"image"];
        wish.isActive = [[wishDict objectForKey:@"isActive"] boolValue];
        wish.amILike = [[wishDict objectForKey:@"liked"] boolValue];
        wish.likesCount = [[wishDict objectForKey:@"likes"] intValue];
        wish.userID = [wishDict objectForKey:@"userId"];
        wish.userName = [wishDict objectForKey:@"username"];
        wish.timestamp = [[wishDict objectForKey:@"timestamp"] intValue];
        
        [resultArray addObject:wish];
    }
    return resultArray;
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

@end
