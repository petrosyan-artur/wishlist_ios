//
//  ACSPinVerifyFullscreenController.m
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

#import "ACSPinVerifyFullscreenController.h"

@interface ACSPinVerifyFullscreenController()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation ACSPinVerifyFullscreenController


- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.actionButton) {
        [self addActionButton];
    }
}

- (void)addActionButton
{
    self.actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.actionButton addTarget:self action:@selector(didSelectActionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.actionButton];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button]-(8)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"button" : self.actionButton}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][button]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"top" : self.topLayoutGuide, @"button" : self.actionButton}]];
    
    if (self.actionButton.imageView.image) {
        self.actionButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(==30)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"button" : self.actionButton}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(==30)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"button" : self.actionButton}]];
    }
    
}

- (void)didSelectActionButton:(UIButton *)actionButton
{
    [self.pinVerifyDelegate pinVerifyController:self didSelectActionButton:actionButton];
}

- (void)addChildControllers
{
    self.containerView = [[UIView alloc] init];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.keyboardController.view];
    [self.containerView addSubview:self.displayController.view];

    // We want that the container is centered on big screens (iPad) but it should spread to all edges on small screens (iPhone)
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:self.topLayoutGuide.length];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:647.0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:375.0];

    top.priority = 998;
    left.priority = 998;
    right.priority = 998;
    bottom.priority = 998;
    centerX.priority = 990;
    centerY.priority = 990;
    height.priority = UILayoutPriorityRequired;
    width.priority = UILayoutPriorityRequired;

    [self.view addConstraints:@[top, left, right, bottom, centerX, centerY]];
    [self.containerView addConstraints:@[height, width]];

    // Layout display and keyboard in the container view
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[display]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"display":self.displayController.view}]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[keyboard]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"keyboard":self.keyboardController.view}]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[display][keyboard]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"display":self.displayController.view, @"keyboard":self.keyboardController.view}]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.keyboardController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.7 constant:0.0]];

}
@end