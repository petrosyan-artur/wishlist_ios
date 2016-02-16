//
//  WebConfiguration.h
//  Wish
//
//  Created by Annie Klekchyan on 1/29/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebConfiguration : NSObject

@property (nonatomic, strong) NSArray *colorsStringArray;
@property (nonatomic, assign) NSInteger maxSymbolsCount;
@property (nonatomic, strong, readonly) NSArray *colorsArray;
@property (nonatomic, strong) NSString *wishEditAlertMessage;
@property (nonatomic, strong) NSString *wishDeleteAlertMessage;
@property (nonatomic, assign) NSInteger wishCheckInterval;

@end
