//
//  ACSPinDisplayController.m
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

#import "ACSPinDisplayController.h"
#import "ACSPinFormatterHelper.h"
#import "ACSPinAnimationHelper.h"
#import "ACSPinDisplayView.h"

@interface ACSPinDisplayController ()

@property (nonatomic) NSInteger completionCallsCount;

@end

@implementation ACSPinDisplayController

- (void)loadView
{
    self.view = self.displayView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.displayView.alertLabel.alpha = 0.0;

    self.completionCallsCount = 0;

    [self updatePasscodeLabelWithString:nil];
}

- (void)updatePasscodeLabelWithString:(NSString *)string
{
    self.displayView.passcodeLabel.text = [ACSPinFormatterHelper secure4DigitsPasscodeStringForString:string];
}

- (void)updateHeaderLabelWithString:(NSString *)string
{
    self.displayView.headerLabel.text = string;
}

- (void)updateAlertLabelWithString:(NSString *)string
{
    self.displayView.alertLabel.text = string;
    self.displayView.alertLabel.alpha = 1.0;
}

- (void)animateForErrorWithAlertString:(NSString *)alertString completion:(void (^)(void))completion
{
    [ACSPinAnimationHelper animateBouncingWithPasscodeLabel:self.displayView.passcodeLabel updateBlock:^{

        [self updatePasscodeLabelWithString:nil];
        self.displayView.alertLabel.text = alertString;
        self.displayView.alertLabel.alpha = 1.0;

    } completion:^{

        if (completion) {
            completion();
        }
    }];
}

- (void)animateForRepetitionWithHeaderString:(NSString *)string withCompletion:(void (^)(void))completion
{
    [ACSPinAnimationHelper animateLeftOutRightInWithLabel:self.displayView.passcodeLabel updateBlock:^{

        [self updatePasscodeLabelWithString:nil];
        
    } completion:^{
        [self checkForCompletionWithBlock:completion];
    }];

    [ACSPinAnimationHelper animateFadeInTextForLabel:self.displayView.headerLabel withString:string updateBlock:^{

    } completion:^{
        [self checkForCompletionWithBlock:completion];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.displayView.alertLabel.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self checkForCompletionWithBlock:completion];
    }];
}



- (void)checkForCompletionWithBlock:(void (^)(void))completion
{
    self.completionCallsCount++;

    if (_completionCallsCount == 3) {
        self.completionCallsCount = 0;
        if (completion) {
            completion();
        }
    }
}

@end
