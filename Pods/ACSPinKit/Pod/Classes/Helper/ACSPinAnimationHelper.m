//
//  ACSPinAnimationHelper.m
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

#import "ACSPinAnimationHelper.h"


@implementation ACSPinAnimationHelper

+ (void)animateLeftOutRightInWithLabel:(UILabel *)label updateBlock:(void (^)(void))updateBlock completion:(void (^)(void))completion
{
    [UIView animateWithDuration:0.3 animations:^{

        label.transform = CGAffineTransformMakeTranslation(-1000, 0);

    } completion:^(BOOL finishedLeft) {

        label.transform = CGAffineTransformMakeTranslation(2000, 0);
        
        if (updateBlock) {
            updateBlock();
        }

        [UIView animateWithDuration:0.3 animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finishedRight) {

            if (completion) {
                completion();
            }

        }];
    }];
}

+ (void)animateFadeInTextForLabel:(UILabel *)label withString:(NSString *)string updateBlock:(void (^)(void))updateBlock completion:(void (^)(void))completion
{
    [UIView animateWithDuration:0.3 animations:^{

        label.alpha = 0.0;

    } completion:^(BOOL finishedFadeOut) {

        label.text = string;
        
        if (updateBlock) {
            updateBlock();
        }

        [UIView animateWithDuration:0.3 animations:^{
            label.alpha = 1.0;
        } completion:^(BOOL finishedFadeIn) {

            if (completion) {
                completion();
            }
        }];
    }];
}

+ (void)animateBouncingWithPasscodeLabel:(UILabel *)label updateBlock:(void (^)(void))updateBlock completion:(void (^)(void))completion
{
    label.transform = CGAffineTransformMakeTranslation(-40, 0);
    
    [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (updateBlock) {
                updateBlock();
            }
        });
        
        label.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];


}

@end
