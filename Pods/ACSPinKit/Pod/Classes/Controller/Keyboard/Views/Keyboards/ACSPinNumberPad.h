//
//  ACSPinNumberPad.h
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

@class ACSPinNumberButton;
@protocol ACSPinNumberPadItem;


@protocol ACSPinNumberPad <NSObject>

- (void)setButton1:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button1;

- (void)setButton2:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button2;

- (void)setButton3:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button3;

- (void)setButton4:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button4;

- (void)setButton5:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button5;

- (void)setButton6:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button6;

- (void)setButton7:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button7;

- (void)setButton8:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button8;

- (void)setButton9:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button9;

- (void)setButton0:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)button0;

- (void)setButtonDelete:(UIButton <ACSPinNumberPadItem> *)button;
- (UIButton <ACSPinNumberPadItem> *)buttonDelete;


@end