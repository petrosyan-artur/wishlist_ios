//
//  ACSPinVerifyController.h
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
#import "ACSPinKeyboardDelegate.h"

@class ACSPinVerifyController;
@protocol ACSPinDisplay;
@protocol ACSPinKeyboard;


@protocol ACSPinVerifyDelegate <NSObject>

@required
- (BOOL)pinValidForPinVerifyController:(ACSPinVerifyController *)pinVerifyController forEnteredPin:(NSString *)pin;

- (NSUInteger)retriesMaxForPinVerifyController:(ACSPinVerifyController *)pinVerifyController;
- (BOOL)alreadyHasRetriesForPinVerifyController:(ACSPinVerifyController *)pinVerifyController;

- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didVerifyPIN:(NSString *)pin;
- (void)pinVerifyControllerDidEnterWrongPIN:(ACSPinVerifyController *)pinVerifyController onlyOneRetryLeft:(BOOL)onlyOneRetryLeft;
- (void)pinVerifyControllerCouldNotVerifyPIN:(ACSPinVerifyController *)pinVerifyController;

@optional
- (NSString *)pinStringForPinVerifyController:(ACSPinVerifyController *)pinVerifyController;
- (void)pinVerifyControllerCouldNotVerifyTouchID:(ACSPinVerifyController *)pinVerifyController withError:(NSError *)error;
- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem;
- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didSelectActionButton:(UIButton *)actionButton;

@end


@interface ACSPinVerifyController : UIViewController <ACSPinKeyboardDelegate>

@property (nonatomic, strong) UIViewController <ACSPinKeyboard> *keyboardController;
@property (nonatomic, strong) UIViewController <ACSPinDisplay> *displayController;

@property (nonatomic, weak) id <ACSPinVerifyDelegate> pinVerifyDelegate;
@property (nonatomic, copy) NSString *headerString;

- (void)addChildControllers;
@end

