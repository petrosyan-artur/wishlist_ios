//
//  ColorDecorationCellObject.m
//  Wish
//
//  Created by Annie Klekchyan on 2/1/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "ColorDecorationCellObject.h"
#import "Definitions.h"

@implementation ColorDecorationCellObject

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.bgColor forKey:@"bgColor"];
    [aCoder encodeObject:self.bgColorString forKey:@"bgColorString"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.bgColor = [aDecoder decodeObjectForKey:@"bgColor"];
        self.bgColorString = [aDecoder decodeObjectForKey:@"bgColorString"];
    }
    return self;
}

@end
