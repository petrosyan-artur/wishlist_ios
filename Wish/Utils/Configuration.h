//
//  Configuration.h
//  AVTMobile
//
//  Created by Anush on 5/27/14.
//
//

#import <Foundation/Foundation.h>
#import "ColorDecorationCellObject.h"

@interface Configuration : NSObject

@property (nonatomic, retain) NSString *pinCode;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *myUserID;
@property (nonatomic, retain) ColorDecorationCellObject *bgDefaultColor;

@end
