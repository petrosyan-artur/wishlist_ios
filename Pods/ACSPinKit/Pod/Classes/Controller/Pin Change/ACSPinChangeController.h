//
//  ACSPinChangeController.h
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
#import "ACSPinCreateController.h"
#import "ACSPinVerifyController.h"

@class ACSPinChangeController;


@protocol ACSPinChangeDelegate <NSObject>

@required
- (BOOL)pinValidForPinVerifyController:(ACSPinChangeController *)pinVerifyController forEnteredPin:(NSString *)pin;

- (NSUInteger)retriesMaxForPinChangeController:(ACSPinChangeController *)pinChangeController;
- (BOOL)alreadyHasRetriesForPinChangeController:(ACSPinChangeController *)pinChangeController;

- (void)pinChangeController:(ACSPinChangeController *)pinChangeController didChangePIN:(NSString *)pin;
- (void)pinChangeControllerCouldNotVerifyOldPIN:(ACSPinChangeController *)pinChangeController;
- (void)pinChangeController:(ACSPinChangeController *)pinChangeController didVerifyOldPIN:(NSString *)pin;
- (void)pinChangeControllerDidEnterWrongOldPIN:(ACSPinChangeController *)pinChangeController onlyOneRetryLeft:(BOOL)onlyOneRetryLeft;

@optional
- (void)pinChangeController:(ACSPinChangeController *)pinChangeController didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem;

@end

@interface ACSPinChangeController : UIViewController <ACSPinVerifyDelegate, ACSPinCreateDelegate>

@property (nonatomic, strong) ACSPinVerifyController *pinVerifyController;
@property (nonatomic, strong) ACSPinCreateController *pinCreateController;

@property (nonatomic, weak) id <ACSPinChangeDelegate> pinChangeDelegate;

@end
