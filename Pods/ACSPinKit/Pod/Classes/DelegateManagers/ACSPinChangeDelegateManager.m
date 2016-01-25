//
//  ACSPinChangeDelegateManager.m
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

#import "ACSPinChangeDelegateManager.h"


@implementation ACSPinChangeDelegateManager


#pragma mark - Change Delegates

- (BOOL)pinValidForPinVerifyController:(ACSPinChangeController *)pinVerifyController forEnteredPin:(NSString *)pin
{
    if (self.validationBlock) {
        return self.validationBlock(pin);
    }
    else {
        return [pin isEqualToString:[self storedPin]];
    }
}

- (BOOL)alreadyHasRetriesForPinChangeController:(ACSPinChangeController *)pinChangeController
{
    return [self.keychainHelper retriesToGoCount] < [self.keychainHelper retriesMax];
}

- (NSUInteger)retriesMaxForPinChangeController:(ACSPinChangeController *)pinChangeController
{
    return [self.keychainHelper retriesToGoCount];
}

- (void)pinChangeController:(ACSPinChangeController *)pinChangeController didChangePIN:(NSString *)pin
{
    if (!self.validationBlock) {
        [self.keychainHelper savePin:pin];
    }
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinChangeController:didChangePin:)]) {
        [self.pinControllerDelegate pinChangeController:pinChangeController didChangePin:pin];
    }

    [pinChangeController dismissViewControllerAnimated:YES completion:nil];
}

- (void)pinChangeController:(ACSPinChangeController *)pinChangeController didVerifyOldPIN:(NSString *)pin
{
    [self.keychainHelper resetRetriesToGoCount];
}

- (void)pinChangeControllerCouldNotVerifyOldPIN:(ACSPinChangeController *)pinChangeController
{
    [self.keychainHelper resetRetriesToGoCount];
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerCouldNotVerifyPin:)]) {
        [self.pinControllerDelegate pinControllerCouldNotVerifyPin:pinChangeController];
    }
    [pinChangeController dismissViewControllerAnimated:YES completion:nil];
}

- (void)pinChangeControllerDidEnterWrongOldPIN:(ACSPinChangeController *)pinChangeController onlyOneRetryLeft:(BOOL)onlyOneRetryLeft
{

    [self.keychainHelper incrementRetryCount];

    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerDidEnterWrongPin:lastRetry:)]) {
        [self.pinControllerDelegate pinControllerDidEnterWrongPin:pinChangeController lastRetry:onlyOneRetryLeft];
    }
}

- (void)pinChangeController:(ACSPinChangeController *)pinChangeController didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem
{
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerDidSelectCancel:)]) {
        [self.pinControllerDelegate pinControllerDidSelectCancel:pinChangeController];
    }
}

@end