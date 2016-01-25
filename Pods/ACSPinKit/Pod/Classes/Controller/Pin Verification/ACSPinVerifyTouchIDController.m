//
//  ACSPinVerifyTouchIDController.m
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

#import "ACSPinVerifyTouchIDController.h"
#import "ACSLocalAuthentication.h"
#import "ACSPinDisplay.h"


@implementation ACSPinVerifyTouchIDController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.localAuthentication) {
        [self.localAuthentication authenticate];
    }
}

- (void)localAuthenticationAuthenticatedSuccessfully:(ACSLocalAuthentication *)localAuthentication
{
    // User authenticated: Get passcode and fill the dots...disable user interaction because we
    // trigger a little delay for dismissing the verify controller.
    NSString *storedPin = [self.pinVerifyDelegate pinStringForPinVerifyController:self];
    [self.displayController updatePasscodeLabelWithString:storedPin];
    self.view.userInteractionEnabled = NO;
    
    // After 0.3 seconds we send the success notification...
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.view.userInteractionEnabled = YES;
        [self.pinVerifyDelegate pinVerifyController:self didVerifyPIN:storedPin];
    });
    
}

- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication failedWithError:(NSError *)error
{
    [self.pinVerifyDelegate pinVerifyControllerCouldNotVerifyTouchID:self withError:error];
}

@end