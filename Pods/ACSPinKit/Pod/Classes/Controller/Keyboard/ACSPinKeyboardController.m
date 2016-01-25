//
//  ACSPinKeyboardController.m
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

#import "ACSPinKeyboardController.h"
#import "ACSPinNumberPad.h"
#import "ACSPinNumberPadItem.h"
#import "ACSI18NHelper.h"


@interface ACSPinKeyboardController ()

@property (nonatomic, strong) NSString *textString;


@end

@implementation ACSPinKeyboardController

- (void)loadView
{
    self.view = self.keyboardView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textString = @"";
    
    [self configureNumberButtons];
    [self configureTargetActions];
}

- (void)configureNumberButtons
{
    [self.keyboardView.button1 setValue:@"1" withTitle:@"1" andSubtitle:@" "];
    [self.keyboardView.button2 setValue:@"2" withTitle:@"2" andSubtitle:@"A B C"];
    [self.keyboardView.button3 setValue:@"3" withTitle:@"3" andSubtitle:@"D E F"];
    [self.keyboardView.button4 setValue:@"4" withTitle:@"4" andSubtitle:@"G H I"];
    [self.keyboardView.button5 setValue:@"5" withTitle:@"5" andSubtitle:@"J K L"];
    [self.keyboardView.button6 setValue:@"6" withTitle:@"6" andSubtitle:@"M N O"];
    [self.keyboardView.button7 setValue:@"7" withTitle:@"7" andSubtitle:@"P Q R S"];
    [self.keyboardView.button8 setValue:@"8" withTitle:@"8" andSubtitle:@"T U V"];
    [self.keyboardView.button9 setValue:@"9" withTitle:@"9" andSubtitle:@"W X Y Z"];
    [self.keyboardView.button0 setValue:@"0" withTitle:@"0"];
    [self.keyboardView.buttonDelete setValue:@"" withTitle:ACSI18NString(kACSButtonDeleteTitle)];
}

- (void)configureTargetActions
{
    NSArray *numberButtons = @[self.keyboardView.button1, self.keyboardView.button2, self.keyboardView.button3, self.keyboardView.button4, self.keyboardView.button5, self.keyboardView.button6, self.keyboardView.button7, self.keyboardView.button8, self.keyboardView.button9, self.keyboardView.button0];
    
    for (UIButton <ACSPinNumberPadItem> *button in numberButtons) {
        [button addTarget:self action:@selector(didSelectNumberButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.keyboardView.buttonDelete addTarget:self action:@selector(didSelectDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions

- (void)didSelectDeleteButton:(UIButton <ACSPinNumberPadItem> *)sender
{

    [self reset];
    [self.keyboardDelegate pinKeyboardController:self didResetText:[self.textString copy]];
}

- (void)didSelectNumberButton:(UIButton <ACSPinNumberPadItem> *)sender
{
    
    // Safe guard: Maximum count of 4 digits!
    if (self.textString.length == 4) {
        return;
    }

    NSString *character = sender.value;
    self.textString = [self.textString stringByAppendingString:character];

    // Notify delegate that the user typed in a number
    [self.keyboardDelegate pinKeyboardController:self didEnterCharacter:[character copy] textString:[self.textString copy]];

    // If we reached a count of 4 digits, we notify the delegate about the case that the user entered the complete pin
    if (self.textString.length == 4) {
        [self.keyboardDelegate pinKeyboardController:self didFinishEnteringText:[self.textString copy]];
    }
    
}

- (void)reset
{
    self.textString = @"";
}

@end
