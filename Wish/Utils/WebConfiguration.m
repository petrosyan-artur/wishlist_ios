//
//  WebConfiguration.m
//  Wish
//
//  Created by Annie Klekchyan on 1/29/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "WebConfiguration.h"

@implementation WebConfiguration

- (void) setColorsStringArray:(NSArray *)colorsStringArray{
    
    _colorsStringArray = colorsStringArray;
    [self setColorsArray];
}

- (void) setColorsArray{
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    for (NSString *colorString in self.colorsStringArray) {
        
        NSArray *colorItems = [colorString componentsSeparatedByString:@","];
        float rValue = [[colorItems objectAtIndex:0] floatValue];
        float gValue = [[colorItems objectAtIndex:1] floatValue];
        float bValue = [[colorItems objectAtIndex:2] floatValue];
        UIColor *currentColor = [UIColor colorWithRed:rValue/255.0 green:gValue/255.0 blue:bValue/255.0 alpha:1];
        [colors addObject:currentColor];
    }
    
    _colorsArray = colors;
}

@end
