//
//  WishObject.m
//  Wish
//
//  Created by Annie Klekchyan on 2/3/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "WishObject.h"

@implementation WishObject

- (id) init{
    self = [super init];
    if (self) {
        
        self.decoration = [[DecorationObject alloc] init];
    }
    return(self);
}

@end
