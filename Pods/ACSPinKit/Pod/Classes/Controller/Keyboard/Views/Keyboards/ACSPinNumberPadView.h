//
//  ACSPinNumberPadView.h
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
#import <UIKit/UIKit.h>
#import "ACSPinNumberPad.h"

@protocol ACSPinNumberPadItem;


@interface ACSPinNumberPadView : UIView <ACSPinNumberPad>

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor buttonTintColor:(UIColor *)buttonTintColor buttonTitleColor:(UIColor *)buttonTitleColor buttonHighlightColor:(UIColor *)buttonHighlightColor;

@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button1;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button2;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button3;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button4;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button5;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button6;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button7;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button8;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button9;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *button0;
@property (nonatomic, strong) UIButton <ACSPinNumberPadItem> *buttonDelete;

@property (nonatomic, strong) UIColor *buttonTintColor;
@property (nonatomic, strong) UIColor *buttonTitleColor;
@property (nonatomic, strong) UIColor *buttonHighlightColor;

@end