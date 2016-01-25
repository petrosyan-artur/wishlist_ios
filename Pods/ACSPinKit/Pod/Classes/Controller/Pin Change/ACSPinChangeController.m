//
//  ACSPinChangeController.m
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

#import "ACSPinChangeController.h"
#import "ACSI18NHelper.h"


@implementation ACSPinChangeController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:ACSI18NString(kACSButtonCancelTitle)
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(didSelectCancelButtonItem:)];
    self.navigationItem.leftBarButtonItem = barButtonItem;

    [self addChildControllers];

    self.view.backgroundColor = self.pinVerifyController.view.backgroundColor;
    self.pinCreateController.view.hidden = YES;
}

- (void)didSelectCancelButtonItem:(UIBarButtonItem *)cancelButtonItem
{
    [self.pinChangeDelegate pinChangeController:self didSelectCancelButtonItem:cancelButtonItem];
}

- (void)addChildControllers
{
    [self addChildViewController:self.pinVerifyController];
    [self.view addSubview:self.pinVerifyController.view];
    [self.pinVerifyController didMoveToParentViewController:self];

    [self addChildViewController:self.pinCreateController];
    [self.view addSubview:self.pinCreateController.view];
    [self.pinCreateController didMoveToParentViewController:self];

    self.pinVerifyController.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.pinCreateController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[verify]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"verify":self.pinVerifyController.view}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[create]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"create":self.pinCreateController.view}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][create]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"top":self.topLayoutGuide, @"create":self.pinCreateController.view}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][verify]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"top":self.topLayoutGuide, @"verify":self.pinVerifyController.view}]];
    
}

- (BOOL)pinValidForPinVerifyController:(ACSPinVerifyController *)pinVerifyController forEnteredPin:(NSString *)pin
{
    return [self.pinChangeDelegate pinValidForPinVerifyController:self forEnteredPin:pin];
}

- (BOOL)alreadyHasRetriesForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self.pinChangeDelegate alreadyHasRetriesForPinChangeController:self];
}

- (NSUInteger)retriesMaxForPinVerifyController:(ACSPinVerifyController *)pinVerifyController
{
    return [self.pinChangeDelegate retriesMaxForPinChangeController:self];
}

- (void)pinVerifyController:(ACSPinVerifyController *)pinVerifyController didVerifyPIN:(NSString *)pin
{
    self.pinCreateController.view.hidden = NO;
    self.pinVerifyController.view.hidden = YES;

    [self.pinChangeDelegate pinChangeController:self didVerifyOldPIN:pin];
}

- (void)pinVerifyControllerDidEnterWrongPIN:(ACSPinVerifyController *)pinController onlyOneRetryLeft:(BOOL)onlyOneRetryLeft
{
    [self.pinChangeDelegate pinChangeControllerDidEnterWrongOldPIN:self onlyOneRetryLeft:onlyOneRetryLeft];
}

- (void)pinVerifyControllerCouldNotVerifyPIN:(ACSPinVerifyController *)pinController
{
    [self.pinChangeDelegate pinChangeControllerCouldNotVerifyOldPIN:self];
}

- (void)pinCreateController:(ACSPinCreateController *)pinCreateController didCreatePIN:(NSString *)pin
{
    [self.pinChangeDelegate pinChangeController:self didChangePIN:pin];
}

@end
