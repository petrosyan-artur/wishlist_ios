//
//  ACSI18NHelper.h
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

#define ACSI18NString(key) \
        [ACSI18NHelper i18nStringForKey:(key)]

extern NSString* const kACSButtonCancelTitle;
extern NSString* const kACSButtonActionTitle;
extern NSString* const kACSButtonDeleteTitle;

extern NSString* const kACSVerifyHeaderText;
extern NSString* const kACSVerifyAlertInitialText;
extern NSString* const kACSVerifyAlertSingularText;
extern NSString* const kACSVerifyAlertPluralText;

extern NSString* const kACSChangeHeaderText;

extern NSString* const kACSCreateHeaderInitialText;
extern NSString* const kACSCreateHeaderRepeatText;
extern NSString* const kACSCreateAlertText;

extern NSString* const kACSTouchIDReasonText;
extern NSString* const kACSTouchIDFallbackButtonTitle;


@interface ACSI18NHelper : NSObject

+ (NSString *)i18nStringForKey:(NSString *)key;

@end