//
//  ACSPinVerifyController.m
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

#import "ACSPinVerifyController.h"

#import "ACSPinDisplay.h"
#import "ACSPinKeyboard.h"
#import "ACSI18NHelper.h"


@interface ACSPinVerifyController()

@property (nonatomic) NSUInteger retriesCount;
@property (nonatomic) NSUInteger retriesMax;

@end

@implementation ACSPinVerifyController

#pragma mark - View Controller lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:ACSI18NString(kACSButtonCancelTitle)
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(didSelectCancelButtonItem:)];
    self.navigationItem.leftBarButtonItem = barButtonItem;


    [self addChildControllers];
    self.view.backgroundColor = self.displayController.view.backgroundColor;
    [self.displayController updateHeaderLabelWithString:self.headerString];

    // Ask delegate for retries max count
    self.retriesCount = [self.pinVerifyDelegate retriesMaxForPinVerifyController:self];

    // Ask delegate if we already have some retries...(user already made wrong inputs)
    BOOL alreadyHasRetries = [self.pinVerifyDelegate alreadyHasRetriesForPinVerifyController:self];

    if (alreadyHasRetries) {
        [self.displayController updateAlertLabelWithString:[NSString stringWithFormat:ACSI18NString(kACSVerifyAlertInitialText), (unsigned long)self.retriesCount]];
    }
}

- (void)didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem
{
    [self.pinVerifyDelegate pinVerifyController:self didSelectCancelButtonItem:cancelButtonItem];
}

- (void)addChildControllers
{
    [self addChildViewController:self.keyboardController];
    [self.view addSubview:self.keyboardController.view];
    [self.keyboardController didMoveToParentViewController:self];

    [self addChildViewController:self.displayController];
    [self.view addSubview:self.displayController.view];
    [self.displayController didMoveToParentViewController:self];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[display]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"display":self.displayController.view}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[keyboard]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"keyboard":self.keyboardController.view}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][display][keyboard(==display)]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"top":self.topLayoutGuide, @"display":self.displayController.view, @"keyboard":self.keyboardController.view}]];
}


#pragma mark - Keyboard controller delegate

- (void)pinKeyboardController:(UIViewController <ACSPinKeyboard> *)pinKeyboardController didEnterCharacter:(NSString *)character textString:(NSString *)textString
{
    [self.displayController updatePasscodeLabelWithString:textString];
}

- (void)pinKeyboardController:(UIViewController <ACSPinKeyboard> *)pinKeyboardController didFinishEnteringText:(NSString *)textString
{
    BOOL valid = [self.pinVerifyDelegate pinValidForPinVerifyController:self forEnteredPin:textString];
    
    if (!valid) {
        [self handleWrongPinEntering];
        return;
    }

    [self.pinVerifyDelegate pinVerifyController:self didVerifyPIN:textString];
}

- (void)pinKeyboardController:(UIViewController <ACSPinKeyboard> *)pinKeyboardController didResetText:(NSString *)textString
{
    [self.displayController updatePasscodeLabelWithString:textString];
}

#pragma mark - Wrong PIN Handling

- (void)handleWrongPinEntering
{
    self.retriesCount--;
    NSString *alertString = (self.retriesCount == 1) ? ACSI18NString(kACSVerifyAlertSingularText) : [NSString stringWithFormat:ACSI18NString(kACSVerifyAlertPluralText), (unsigned long) self.retriesCount];

    [self.displayController animateForErrorWithAlertString:alertString completion:nil];
    [self.keyboardController reset];
    [self sendProperDelegateNotification];
}

#pragma mark - Delegate notifications

- (void)sendProperDelegateNotification
{
    if (self.retriesCount == 1) {
        [self.pinVerifyDelegate pinVerifyControllerDidEnterWrongPIN:self onlyOneRetryLeft:YES];
    }
    else if (self.retriesCount == 0) {
        [self.pinVerifyDelegate pinVerifyControllerCouldNotVerifyPIN:self];
    }
    else {
        [self.pinVerifyDelegate pinVerifyControllerDidEnterWrongPIN:self onlyOneRetryLeft:NO];
    }
}

@end
