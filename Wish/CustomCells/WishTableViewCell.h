//
//  WishTableViewCell.h
//  Wish
//
//  Created by Annie Klekchyan on 2/3/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WishObject.h"
#import "Definitions.h"

@protocol WishTableViewCellDelegate <NSObject>

- (void) editWishWithWishObject:(WishObject *) wish;
- (void) deleteWishWithWishObject:(WishObject *) wish;
- (void) openUserWishList:(WishObject *) wish;

@end

@interface WishTableViewCell : UITableViewCell <WishTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UIButton *userNameButton;

@property (strong, nonatomic) IBOutlet UILabel *creationDateLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIView *contView;
@property (strong, nonatomic) IBOutlet UILabel *likesCountLabel;
@property (strong, nonatomic) WishObject *wish;
@property (assign, nonatomic) PageIndex pageIndex;
@property (assign, nonatomic) id<WishTableViewCellDelegate> delegate;

- (IBAction)likeButtonAction:(UIButton *)sender;
- (void) setLikeButtonState:(BOOL) amILike;
- (void) setLikeLabelWithCount:(NSInteger) count;
- (IBAction)userNameButtonAction:(UIButton *)sender;

@end
