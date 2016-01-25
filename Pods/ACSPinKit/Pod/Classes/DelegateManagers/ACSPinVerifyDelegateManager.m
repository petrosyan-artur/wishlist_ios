//
//  ACSPinVerifyDelegateManager.m
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

#import "ACSPinVerifyDelegateManager.h"


@implementation ACSPinVerifyDelegateManager

#pragma mark - Verify Delegates

- (NSString *)pinStringForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self storedPin];
}

- (BOOL)pinValidForPinVerifyController:(ACSPinVerifyController *)pinVerifyController forEnteredPin:(NSString *)pin
{
    if (self.validationBlock) {
        return self.validationBlock(pin);
    }
    else {
        return [pin isEqualToString:[self storedPin]];
    }
}

- (BOOL)alreadyHasRetriesForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self.keychainHelper retriesToGoCount] < [self.keychainHelper retriesMax];
}

- (NSUInteger)retriesMaxForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self.keychainHelper retriesToGoCount];
}

- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didVerifyPIN:(NSString *)pin
{
    [self.keychainHelper resetRetriesToGoCount];
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinController:didVerifyPin:)]) {
        [self.pinControllerDelegate pinController:pinVerifyController didVerifyPin:pin];
    }
    [pinVerifyController dismissViewControllerAnimated:YES completion:nil];
}

- (void)pinVerifyControllerDidEnterWrongPIN:(ACSPinVerifyController *)pinVerifyController onlyOneRetryLeft:(BOOL)onlyOneRetryLeft
{

    [self.keychainHelper incrementRetryCount];
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerDidEnterWrongPin:lastRetry:)]) {
        [self.pinControllerDelegate pinControllerDidEnterWrongPin:pinVerifyController lastRetry:onlyOneRetryLeft];
    }
}


- (void)pinVerifyControllerCouldNotVerifyPIN:(ACSPinVerifyController *)pinVerifyController
{
    [self.keychainHelper resetRetriesToGoCount];
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerCouldNotVerifyPin:)]) {
        [self.pinControllerDelegate pinControllerCouldNotVerifyPin:pinVerifyController];
    }
    [pinVerifyController dismissViewControllerAnimated:YES completion:nil];

}

- (void)pinVerifyControllerCouldNotVerifyTouchID:(ACSPinVerifyController *)pinVerifyController withError:(NSError *)error
{
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerCouldNotVerifyTouchID:withError:)]) {
        [self.pinControllerDelegate pinControllerCouldNotVerifyTouchID:pinVerifyController withError:error];
    }
}

- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem
{
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinControllerDidSelectCancel:)]) {
        [self.pinControllerDelegate pinControllerDidSelectCancel:pinVerifyController];
    }
}

- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didSelectActionButton:(UIButton *)actionButton
{
    if ([self.pinControllerDelegate respondsToSelector:@selector(pinController:didSelectCustomActionButton:)]) {
        [self.pinControllerDelegate pinController:pinVerifyController didSelectCustomActionButton:actionButton];
    }
}

@end