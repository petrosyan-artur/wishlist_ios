//
//  ACSPinNumberButton.m
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

#import "ACSPinNumberButton.h"
#import "ACSPinNumberPadItem.h"


@interface ACSPinNumberButton ()

@property (nonatomic) NSString *value;

@end

@implementation ACSPinNumberButton

- (void)setValue:(NSString *)value withTitle:(NSString *)title andSubtitle:(NSString *)subtitle
{
    self.value = value;

    title = [title stringByAppendingString:@"\n"];
    NSMutableAttributedString *totalString = [[NSMutableAttributedString alloc] initWithString:title attributes:[self attributesForTitle]];
    NSMutableAttributedString *subtitleString = [[NSMutableAttributedString alloc] initWithString:subtitle attributes:[self attributesForSubtitle]];
    [totalString appendAttributedString:subtitleString];

    [self setAttributedTitle:totalString forState:UIControlStateNormal];

    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.minimumScaleFactor = 0.5;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setValue:(NSString *)value withTitle:(NSString *)title
{
    self.value = value;

    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:title attributes:[self attributesForTitle]];

    [self setAttributedTitle:titleString forState:UIControlStateNormal];

    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.minimumScaleFactor = 0.5;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (NSDictionary *)attributesForTitle
{
    return @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],
            NSForegroundColorAttributeName : self.titleColor};
}

- (NSDictionary *)attributesForSubtitle
{
    return @{NSFontAttributeName : [UIFont systemFontOfSize:8],
            NSForegroundColorAttributeName : self.titleColor};
}


- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];

    UIColor *newColor = highlighted ? self.highlightColor : self.backColor;

    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.backgroundColor = newColor;
    } completion:nil];
}


@end
