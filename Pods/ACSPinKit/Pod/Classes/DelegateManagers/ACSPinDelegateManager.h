//
//  ACSPinDelegateManager.h
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

#import <Foundation/Foundation.h>
#import "ACSKeychainHelper.h"
#import "ACSPinControllerDelegate.h"


@protocol ACSPinControllerDelegate;
@class ACSKeychainHelper;
@class ACSPinVerifyDelegateManager;
@class ACSPinCreateDelegateManager;
@class ACSPinChangeDelegateManager;


@interface ACSPinDelegateManager : NSObject

@property (nonatomic, weak) id <ACSPinControllerDelegate> pinControllerDelegate;
@property (nonatomic, strong) ACSKeychainHelper *keychainHelper;

@property (nonatomic, strong) ACSPinChangeDelegateManager *pinChangeDelegateManager;
@property (nonatomic, strong) ACSPinCreateDelegateManager *pinCreateDelegateManager;
@property (nonatomic, strong) ACSPinVerifyDelegateManager *pinVerifyDelegateManager;

@property (nonatomic) NSUInteger retriesMax;
@property (nonatomic, copy) BOOL (^validationBlock)(NSString *pin);

- (NSString *)storedPin;
- (BOOL)storePIN:(NSString *)pin;
- (BOOL)resetPIN;

@end