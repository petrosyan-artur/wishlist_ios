//
//  ACSKeychainHelper.m
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

#import "ACSKeychainHelper.h"
#import "ACSPinFormatterHelper.h"
#import <FDKeychain/FDKeychain.h>

@interface ACSKeychainHelper ()

@property (nonatomic, copy) NSString *pinServiceName;
@property (nonatomic, copy) NSString *pinUserName;
@property (nonatomic, copy) NSString *accessGroup;

@property (nonatomic, copy) NSString *pinRetriesMaxName;
@property (nonatomic, copy) NSString *pinRetriesCountName;
@end


@implementation ACSKeychainHelper

- (instancetype)initWithPinServiceName:(NSString *)pinServiceName pinUserName:(NSString *)pinUserName accessGroup:(NSString *)accessGroup;
{

    self = [super init];
    if (self) {
        
        NSAssert(pinServiceName.length > 0, @"ACSKeychainHelper initialization: Parameter 'pinServiceName' must not be nil!");
        NSAssert(pinUserName.length > 0, @"ACSKeychainHelper initialization: Parameter 'pinUserName' must not be nil!");
        
        self.pinServiceName = pinServiceName;
        self.pinUserName = pinUserName;
        self.accessGroup = accessGroup;
        self.pinRetriesMaxName = [self.pinUserName stringByAppendingString:@"_pinRetriesMax"];
        self.pinRetriesCountName = [self.pinUserName stringByAppendingString:@"_pinRetriesCount"];
    }
    return self;
}

#pragma mark - PIN Management

- (BOOL)savePin:(NSString *)pin
{
    NSError *error;
    [FDKeychain saveItem:pin forKey:self.pinUserName forService:self.pinServiceName inAccessGroup:self.accessGroup withAccessibility:FDKeychainAccessibleWhenUnlocked error:&error];
    return error == nil;
}

- (BOOL)resetPin
{
    NSError *error;
    [FDKeychain deleteItemForKey:self.pinUserName forService:self.pinServiceName inAccessGroup:self.accessGroup error:&error];
    return error == nil;
}

- (NSString *)savedPin
{
    NSError *error;
    NSString *pin = [FDKeychain itemForKey:self.pinUserName forService:self.pinServiceName inAccessGroup:self.accessGroup error:&error];
    return error ? nil : pin;
}

#pragma mark - Retries Management

- (BOOL)saveRetriesMax:(NSUInteger)retriesMax
{
    NSString *retriesMaxString = [ACSPinFormatterHelper numberStringFromInteger:retriesMax];
    NSError *error;
    [FDKeychain saveItem:retriesMaxString forKey:self.pinRetriesMaxName forService:self.pinServiceName inAccessGroup:self.accessGroup withAccessibility:FDKeychainAccessibleWhenUnlocked error:&error];
    return error == nil;
}

- (NSUInteger)retriesMax
{
    NSError *error = nil;
    NSString *currentMaxString = [FDKeychain itemForKey:self.pinRetriesMaxName forService:self.pinServiceName inAccessGroup:self.accessGroup error:&error];
    return error ? NSNotFound : [ACSPinFormatterHelper integerFromNumberString:currentMaxString];
}

- (BOOL)incrementRetryCount
{
    // Default value, if we don't have a current count, is 1.
    NSString *newCountString = @"1";
    NSString *currentCountString = [FDKeychain itemForKey:self.pinRetriesCountName forService:self.pinServiceName inAccessGroup:self.accessGroup error:nil];
    // If we have a current value, reset the default value
    if (currentCountString.length > 0) {
        NSUInteger currentCount = [ACSPinFormatterHelper integerFromNumberString:currentCountString];
        NSUInteger newCount = currentCount + 1;
        newCountString = [ACSPinFormatterHelper numberStringFromInteger:newCount];
    }

    // Save the new count...
    NSError *error;
    [FDKeychain saveItem:newCountString forKey:self.pinRetriesCountName forService:self.pinServiceName inAccessGroup:self.accessGroup withAccessibility:FDKeychainAccessibleWhenUnlocked error:&error];
    return error == nil;
}

- (NSUInteger)retriesToGoCount
{
    NSString *currentCountString = [FDKeychain itemForKey:self.pinRetriesCountName forService:self.pinServiceName inAccessGroup:self.accessGroup error:nil];
    NSString *currentMaxString = [FDKeychain itemForKey:self.pinRetriesMaxName forService:self.pinServiceName inAccessGroup:self.accessGroup error:nil];
    
    if (!currentMaxString.length > 0) {
        NSException* noMaxException = [NSException exceptionWithName:@"ACSKeychainHelperException"
                                                              reason:@"No Retry max count saved"
                                                            userInfo:nil];
        [noMaxException raise];
    }
    
    if (!currentCountString.length > 0) {
        return [ACSPinFormatterHelper integerFromNumberString:currentMaxString];
    }
    
    NSUInteger maxCount = [ACSPinFormatterHelper integerFromNumberString:currentMaxString];
    NSUInteger currentCount = [ACSPinFormatterHelper integerFromNumberString:currentCountString];
    
    return maxCount - currentCount;
}

- (BOOL)resetRetriesToGoCount
{
    NSError *error;
    [FDKeychain saveItem:@"0" forKey:self.pinRetriesCountName forService:self.pinServiceName inAccessGroup:self.accessGroup withAccessibility:FDKeychainAccessibleWhenUnlocked error:&error];
    return error == nil;
}

@end
