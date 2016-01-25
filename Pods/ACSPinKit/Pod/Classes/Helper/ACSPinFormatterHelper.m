//
//  ACSPinFormatterHelper.m
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

#import "ACSPinFormatterHelper.h"

@implementation ACSPinFormatterHelper


+ (NSString*)secure4DigitsPasscodeStringForString:(NSString *)string
{

    if (string.length == 0 || !string) {
        return @"○  ○  ○  ○";
    }

    NSString *passcodeString = @"";
    for (int i = 0; i < string.length; i++) {
        passcodeString = [passcodeString stringByAppendingString:@"●  "];
    }

    NSInteger nonNumbersCount = 4 - string.length;

    for (int j = 0; j < nonNumbersCount; j++) {
        passcodeString = [passcodeString stringByAppendingString:@"○  "];
    }

    passcodeString = [passcodeString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    return passcodeString;

}



+ (NSString *)numberStringFromInteger:(NSUInteger)integer
{
    NSString *numberString = [NSString stringWithFormat:@"%ld", (long)integer];
    return numberString;
}

+ (NSUInteger)integerFromNumberString:(NSString *)numberString
{
    NSUInteger integer = [numberString integerValue];
    return integer;
}

@end
