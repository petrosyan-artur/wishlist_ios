//
//  ACSPinNumberPadCircleView.m
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

#import "ACSPinNumberPadCircleView.h"
#import "ACSPinNumberCircleButton.h"


@interface ACSPinNumberPadCircleView ()

@property (nonatomic, strong) NSMutableDictionary *viewsDictionary;

@end


@implementation ACSPinNumberPadCircleView

- (instancetype)initWithBackgroundColor:(UIColor*)backgroundColor buttonTintColor:(UIColor *)buttonTintColor buttonTitleColor:(UIColor *)buttonTitleColor buttonHighlightColor:(UIColor *)buttonHighlightColor
{
    self = [super init];
    if (self) {
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        self.buttonTintColor = buttonTintColor;
        self.buttonTitleColor = buttonTitleColor;
        self.buttonHighlightColor = buttonHighlightColor;
        
        self.viewsDictionary = [NSMutableDictionary dictionary];
        [self setupButtons];
        [self setupSpacingViews];
    }
    
    return self;
}

- (void)setupSpacingViews
{
    // create 21 spacer views
    for (int i = 0; i < 22; i++) {
        UIView *spacerView = [[UIView alloc] init];
        spacerView.translatesAutoresizingMaskIntoConstraints = NO;
        spacerView.hidden = YES;
        [self addSubview:spacerView];
        self.viewsDictionary[[NSString stringWithFormat:@"spacer%d", i + 1]] = spacerView;
    }
}

- (void)setupButtons
{
    self.button0 = [[ACSPinNumberCircleButton alloc] init];
    self.button1 = [[ACSPinNumberCircleButton alloc] init];
    self.button2 = [[ACSPinNumberCircleButton alloc] init];
    self.button3 = [[ACSPinNumberCircleButton alloc] init];
    self.button4 = [[ACSPinNumberCircleButton alloc] init];
    self.button5 = [[ACSPinNumberCircleButton alloc] init];
    self.button6 = [[ACSPinNumberCircleButton alloc] init];
    self.button7 = [[ACSPinNumberCircleButton alloc] init];
    self.button8 = [[ACSPinNumberCircleButton alloc] init];
    self.button9 = [[ACSPinNumberCircleButton alloc] init];
    ACSPinNumberCircleButton *deleteButton = [[ACSPinNumberCircleButton alloc] init];
    deleteButton.hideCircle = YES;
    self.buttonDelete = deleteButton;

    NSArray *buttonArray = @[self.button0, self.button1, self.button2,
            self.button3, self.button4, self.button5,
            self.button6, self.button7, self.button8,
            self.button9, self.buttonDelete];

    for (ACSPinNumberCircleButton *button in buttonArray) {

        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.titleColor = self.buttonTitleColor;
        button.highlightColor = self.buttonHighlightColor;
        button.backColor = [UIColor clearColor];
        
        [self addSubview:button];
    }
    deleteButton.highlightColor = [UIColor clearColor];

    [self.viewsDictionary addEntriesFromDictionary:@{
            @"button0" : self.button0,
            @"button1" : self.button1,
            @"button2" : self.button2,
            @"button3" : self.button3,
            @"button4" : self.button4,
            @"button5" : self.button5,
            @"button6" : self.button6,
            @"button7" : self.button7,
            @"button8" : self.button8,
            @"button9" : self.button9,
            @"buttonDelete" : self.buttonDelete
    }];
}

- (void)updateConstraints
{
    [super updateConstraints];

    [self removeConstraints:self.constraints];

    // Basic grid layout
    NSString *layout1 = @"V:|[spacer1(>=1)][button1(>=40)][spacer2(==spacer1)][button4(==button1)][spacer3(==spacer1)][button7(==button1)][spacer4(==spacer1)][spacer22(==button1)][spacer5(==spacer1)]|";
    NSString *layout2 = @"H:|[spacer6(>=1)][button1][spacer7(==spacer6)][button2(==button1)][spacer8(==spacer6)][button3(==button1)][spacer9(==spacer6)]|";
    NSString *layout3 = @"H:|[spacer10(==spacer6)][button4(==button1)][spacer11(==spacer6)][button5(==button1)][spacer12(==spacer6)][button6(==button1)][spacer13(==spacer6)]|";
    NSString *layout4 = @"H:|[spacer14(==spacer6)][button7(==button1)][spacer15(==spacer6)][button8(==button1)][spacer16(==spacer6)][button9(==button1)][spacer17(==spacer6)]|";
    NSString *layout5 = @"H:|[spacer18(==spacer6)][spacer22(==button1)][spacer19(==spacer6)][button0(==button1)][spacer20(==spacer6)][buttonDelete(==button1)][spacer21(==spacer6)]|";

    // Equal heights...
    NSString *layout6 = @"V:[button2(==button1)]";
    NSString *layout7 = @"V:[button3(==button1)]";
    NSString *layout8 = @"V:[button5(==button1)]";
    NSString *layout9 = @"V:[button6(==button1)]";
    NSString *layout10 = @"V:[button8(==button1)]";
    NSString *layout11 = @"V:[button9(==button1)]";
    NSString *layout12 = @"V:[button0(==button1)]";
    NSString *layout13 = @"V:[buttonDelete(==button1)]";

    NSArray *leadingToTrailings = @[layout1, layout6, layout7, layout8, layout9, layout10, layout11, layout12, layout13];
    NSArray *alignAllTops = @[layout2, layout3, layout4, layout5];

    for (NSString *format in leadingToTrailings) {
        [self setConstraintWithFormat:format options:NSLayoutFormatDirectionLeadingToTrailing];
    }
    for (NSString *format in alignAllTops) {
        [self setConstraintWithFormat:format options:NSLayoutFormatAlignAllTop];
    }

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.button1 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
}

- (void)setConstraintWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format
                                                                 options:options
                                                                 metrics:nil
                                                                   views:self.viewsDictionary]];
}


@end