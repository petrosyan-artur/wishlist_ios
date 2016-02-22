//
//  WishObject.h
//  Wish
//
//  Created by Annie Klekchyan on 2/3/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DecorationObject.h"

@interface WishObject : NSObject

@property (nonatomic, strong) NSString *wishID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) DecorationObject *decoration;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) BOOL amILike;
@property (nonatomic, assign) NSInteger likesCount;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) NSInteger timestamp;

@end
