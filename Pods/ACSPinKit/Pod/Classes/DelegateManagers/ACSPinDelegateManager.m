//
//  ACSPinDelegateManager.m
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

#import "ACSPinDelegateManager.h"
#import "ACSPinVerifyDelegateManager.h"
#import "ACSPinCreateDelegateManager.h"
#import "ACSPinChangeDelegateManager.h"


@implementation ACSPinDelegateManager

#pragma mark - Keychain access

- (NSString *)storedPin
{
    return [self.keychainHelper savedPin];
}

- (BOOL)storePIN:(NSString *)pin
{
    return [self.keychainHelper savePin:pin];
}

- (BOOL)resetPIN
{
    return [self.keychainHelper resetPin];
}

- (void)setRetriesMax:(NSUInteger)retriesMax
{
    _retriesMax = retriesMax;
    [self.keychainHelper saveRetriesMax:_retriesMax];
}

- (void)setValidationBlock:(BOOL (^)(NSString *))validationBlock
{
    _validationBlock = validationBlock;
    _pinVerifyDelegateManager.validationBlock = _validationBlock;
    _pinChangeDelegateManager.validationBlock = _validationBlock;
    _pinCreateDelegateManager.validationBlock = _validationBlock;
}

- (void)setPinChangeDelegateManager:(ACSPinChangeDelegateManager *)pinChangeDelegateManager
{
    _pinChangeDelegateManager = pinChangeDelegateManager;

    self.pinChangeDelegateManager.keychainHelper = self.keychainHelper;
    self.pinChangeDelegateManager.pinControllerDelegate = self.pinControllerDelegate;
}

- (void)setPinCreateDelegateManager:(ACSPinCreateDelegateManager *)pinCreateDelegateManager
{
    _pinCreateDelegateManager = pinCreateDelegateManager;

    self.pinCreateDelegateManager.keychainHelper = self.keychainHelper;
    self.pinCreateDelegateManager.pinControllerDelegate = self.pinControllerDelegate;
}

- (void)setPinVerifyDelegateManager:(ACSPinVerifyDelegateManager *)pinVerifyDelegateManager
{
    _pinVerifyDelegateManager = pinVerifyDelegateManager;

    self.pinVerifyDelegateManager.keychainHelper = self.keychainHelper;
    self.pinVerifyDelegateManager.pinControllerDelegate = self.pinControllerDelegate;
}

@end