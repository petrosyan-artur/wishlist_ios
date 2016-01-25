//
//  ACSI18NHelper.m
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

#import "ACSI18NHelper.h"

NSString* const kACSButtonCancelTitle = @"acspinkit.button.cancel.title";
NSString* const kACSButtonActionTitle = @"acspinkit.button.action.title";
NSString* const kACSButtonDeleteTitle = @"acspinkit.button.delete.title";

NSString* const kACSVerifyHeaderText = @"acspinkit.verify.header.text";
NSString* const kACSVerifyAlertInitialText = @"acspinkit.verify.alert.initial.text";
NSString* const kACSVerifyAlertSingularText = @"acspinkit.verify.alert.singular.text";
NSString* const kACSVerifyAlertPluralText = @"acspinkit.verify.alert.plural.text";

NSString* const kACSChangeHeaderText = @"acspinkit.change.header.text";

NSString* const kACSCreateHeaderInitialText = @"acspinkit.create.header.initial.text";
NSString* const kACSCreateHeaderRepeatText = @"acspinkit.create.header.repeat.text";
NSString* const kACSCreateAlertText = @"acspinkit.create.alert.text";

NSString* const kACSTouchIDReasonText = @"acspinkit.touchid.reason.text";
NSString* const kACSTouchIDFallbackButtonTitle = @"acspinkit.touchid.button.fallback.title";

@implementation ACSI18NHelper

+ (NSString *)i18nStringForKey:(NSString *)key {
    
    if (!key) {
        return @"";
    }
    
    
    // If user has own strings table (ACSPinKit_I18NCustom), take the one from his table
    NSString *appSpecificLocalizationString = NSLocalizedStringFromTable(key, @"ACSPinKit_I18NCustom", nil);
    if (appSpecificLocalizationString && ![key isEqualToString:appSpecificLocalizationString]) {
        return appSpecificLocalizationString;
    }
    // ... otherwise we use the shipped table with this pod
    else if ([self acsPinBundle]) {
        
        NSString *bundleSpecificLocalizationString = NSLocalizedStringFromTableInBundle(key, @"ACSPinKit_I18N", [self acsPinBundle], @"");
        if (![bundleSpecificLocalizationString isEqualToString:key]) {
            return bundleSpecificLocalizationString;
        }
        return key;
    }
    else {
        
        return key;
    }
}

+ (NSBundle *)acsPinBundle {

    NSString *mainBundlePath = [[NSBundle bundleForClass:[ACSI18NHelper class]] resourcePath];
    NSString *frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"ACSPinKitResources.bundle"];
    return [NSBundle bundleWithPath:frameworkBundlePath];
}

@end