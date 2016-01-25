//
//  ACSPinNumberCircleButton.m
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

#import "ACSPinNumberCircleButton.h"


@implementation ACSPinNumberCircleButton

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];

    if (!self.hideCircle) {

        CGFloat radius = CGRectGetMidX(self.bounds);
        self.layer.cornerRadius = radius;
        self.layer.borderWidth = 1;
        self.layer.borderColor = self.titleColor.CGColor;
        self.clipsToBounds = YES;
    }
}

- (void)setValue:(NSString *)value withTitle:(NSString *)title {

    [super setValue:value withTitle:title];
    
    // If we hide the circle border for this button we need to indicate highlighting on a different way. We reapply the
    // attributes for the normal state from superclass for the highlight state (with a lighter text color).
    if (self.hideCircle) {
        
        NSAttributedString *attributedTitleString = [self attributedTitleForState:UIControlStateNormal];
        NSDictionary *attributes = [attributedTitleString attributesAtIndex:0 effectiveRange:NULL];
        NSMutableDictionary *mutableAttributes = [attributes mutableCopy];
        UIColor *highlightColor = mutableAttributes[NSForegroundColorAttributeName];
        mutableAttributes[NSForegroundColorAttributeName] = [highlightColor colorWithAlphaComponent:0.5];
        
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:title attributes:mutableAttributes];
        [self setAttributedTitle:titleString forState:UIControlStateHighlighted];
    }
    
    
}

@end