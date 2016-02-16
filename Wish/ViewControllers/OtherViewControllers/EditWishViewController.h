//
//  EditWishViewController.h
//  Wish
//
//  Created by Annie Klekchyan on 2/16/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WishObject.h"

@interface EditWishViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate>

@property (strong, nonatomic) WishObject *wish;

@end
