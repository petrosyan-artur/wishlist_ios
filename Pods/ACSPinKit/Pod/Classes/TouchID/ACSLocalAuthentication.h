//
//  ACSLocalAuthentication.h
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
#import <LocalAuthentication/LocalAuthentication.h>


@class ACSLocalAuthentication;

@protocol ACSLocalAuthenticationDelegate <NSObject>

@required

- (void)localAuthenticationAuthenticatedSuccessfully:(ACSLocalAuthentication *)localAuthentication;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication failedWithError:(NSError *)error;

@optional

- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication authenticationFailed:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication userCancelled:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication systemCancelled:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication userFallback:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication touchIDNotEnrolled:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication touchIDNotAvailable:(NSError *)error;
- (void)localAuthentication:(ACSLocalAuthentication *)localAuthentication passcodeNotSet:(NSError *)error;

@end


@interface ACSLocalAuthentication : NSObject

/**
* The delegate object that implements the ACSLocalAuthenticationDelegate
*/
@property (nonatomic, weak) id <ACSLocalAuthenticationDelegate> delegate;

/**
* The string which is presented to the user in the authentication dialog
*/
@property (nonatomic, copy) NSString *reasonText;

/**
* Fallback button title. Allows fallback button title customization. A default title "Enter Password" is used when
* this property is left nil. If set to empty string, the button will be hidden.
*/
@property (nonatomic, copy) NSString *fallbackButtonTitle;

/**
* Set desired policy. Currently only 'LAPolicyDeviceOwnerAuthenticationWithBiometrics' is available
*/
@property (nonatomic, assign) LAPolicy policy;

/**
* Evaluates if user and device can use Touch ID.
*
* @param error On input, a pointer to an error object. If Touch ID is not available,
* this pointer is set to an actual error object containing the error information (inspect LAError in the code property).
* You may specify nil for this parameter if you do not want the error information.
*
* @return YES if Touch ID is available for the user and device, NO otherwise
*
*/
+ (BOOL)biometricsAuthenticationAvailable:(NSError **) error;

/**
* Evaluates the policy set. For Touch ID this means, the user is prompted to verify its biometrics (if possible).
* This method triggers callbacks defined in the ACSLocalAuthenticationDelegate
*
* @see ACSLocalAuthenticationDelegate
*/
- (void)authenticate;

@end
