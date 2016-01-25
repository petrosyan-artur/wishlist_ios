//
//  ACSPinController.h
//  Created by Orlando Schäfer
//  
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 arconsis IT-Solutions GmbH <contact@arconsis.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "ACSPinCustomizer.h"
#import "ACSPinControllerDelegate.h"


/**
 This is the main interface class you use for accessing all the features of ACSPinKit
 */
@interface ACSPinController : NSObject

/**
 Customization object for setting different things like colors, titles, messages and images
 */
@property (nonatomic) ACSPinCustomizer *pinCustomizer;

/**
 Set the maximum number of retry attempts. Default value is 3.
 */
@property (nonatomic) NSUInteger retriesMax;

/**
 A validation block used for checking if the pin the user entered was valid. E.g. you can test if the typed in pin unlocks a vault and
 return YES or NO. If you provide this validation block the pin is NOT stored in the keychain.
 */
@property (nonatomic, copy) BOOL (^validationBlock)(NSString *pin);

/**
 Initializes and returns the pin controller object you can use to make further actions.
 
 @param pinServiceName A service name that is used for storing the pin in the keychain.
 @param pinUserName A username that is used for storing the pin in the keychain.
 @param accessGroup The access group used for keychain access. If this parameter is nil the standard group is used.
 
 @return An initialized pin controller object or nil if something went wrong
 */
- (instancetype)initWithPinServiceName:(NSString *)pinServiceName pinUserName:(NSString *)pinUserName accessGroup:(NSString *)accessGroup delegate:(id <ACSPinControllerDelegate>)delegate;

/**
 Returns if Touch ID is available or not (device does not support it, Touch ID is not enrolled etc.)
 You can provide an optional error pointer for getting detailed information if touch id is not available.
 
 @param error An error pointer for getting additional information in case that no touch id is available
 
 
 @return YES if Touch ID is available, NO if not.
 */
- (BOOL)touchIDAvailable:(NSError **)error;

/**
 The controller used for verifying a pin the user enters. You have to present and dismiss the controller manually
 */
- (UIViewController *)verifyControllerForCustomPresentation;

/**
 Full screen controller used for verifying a pin the user enters. You have to present and dismiss the controller manually
 In addition you can provide a boolean value that indicates if Touch ID should be used or not.
 */
- (UIViewController *)verifyControllerFullscreenForCustomPresentationUsingTouchID:(BOOL)touchID;


/**
 Presents the verification controller from a provided view controller
 */
- (void)presentVerifyControllerFromViewController:(UIViewController *)viewController;
/**
 Presents the change pin controller from a provided view controller
 */
- (void)presentChangeControllerFromViewController:(UIViewController *)viewController;
/**
 Presents the pin creation controller from a provided view controller
 */
- (void)presentCreateControllerFromViewController:(UIViewController *)viewController;


/**
 Get the current stored pin. The pin will only be stored in the keychain, if you do not provide a validation block.
 If you want to store the pin manually you have to use the storePin: method.
 */
- (NSString *)storedPin;
/**
 Stores a given pin to the keychain.
 */
- (BOOL)storePin:(NSString *)pin;
/**
 Removes the stored pin from the keychain.
 */
- (BOOL)resetPIN;

@end
