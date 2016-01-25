//
//  ACSPinDisplayView.m
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

#import "ACSPinDisplayView.h"

@implementation ACSPinDisplayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }

    return self;
}

- (void)setupViews
{
    self.imageView = [[UIImageView alloc] init];
    self.headerLabel = [[UILabel alloc] init];
    self.passcodeLabel = [[UILabel alloc] init];
    self.passcodeLabel.font = [UIFont fontWithName:@"Menlo-Regular" size:25.0];
    self.alertLabel = [[UILabel alloc] init];

    
    NSArray *views = @[self.imageView, self.headerLabel, self.passcodeLabel, self.alertLabel];
    NSArray *labels = @[self.headerLabel, self.passcodeLabel, self.alertLabel];
    
    for (UIView *view in views) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
    }
    for (UILabel *label in labels) {
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
    }
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSDictionary *views = @{
                            @"imageView" : self.imageView,
                            @"headerLabel" : self.headerLabel,
                            @"passcodeLabel" : self.passcodeLabel,
                            @"alertLabel" : self.alertLabel
                            };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[imageView]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[headerLabel]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[passcodeLabel]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[alertLabel]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passcodeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView(<=20)]-[headerLabel]-[passcodeLabel]-[alertLabel]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    

}

@end
