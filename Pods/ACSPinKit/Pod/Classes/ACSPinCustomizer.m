//
//  ACSPinCustomizer.m
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

#import "ACSPinCustomizer.h"
#import "ACSI18NHelper.h"

@implementation ACSPinCustomizer

- (instancetype)init
{
    self = [super init];
    if (self) {

        [self resetDefaults];
    }

    return self;
}

- (void)resetDefaults
{
    self.titleImage = nil;
    self.actionButtonImage = nil;
    self.actionButtonString = ACSI18NString(kACSButtonActionTitle);

    self.displayBackgroundColor = [UIColor whiteColor];
    self.headerTitleColor = [UIColor blackColor];
    self.passcodeDotsColor = [UIColor blackColor];
    self.alertTextColor = [UIColor colorWithRed:0.85 green:0 blue:0 alpha:1];

    self.keyboardBackgroundColor = [UIColor lightGrayColor];
    self.keyboardTintColor = [UIColor whiteColor];
    self.keyboardTitleColor = [UIColor darkGrayColor];
    self.keyboardHighlightColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    self.touchIDReasonText = ACSI18NString(kACSTouchIDReasonText);
    self.touchIDFallbackTitle = ACSI18NString(kACSTouchIDFallbackButtonTitle);
}

@end
