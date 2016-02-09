//
//  WishTableViewCell.h
//  Wish
//
//  Created by Annie Klekchyan on 2/3/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) IBOutlet UILabel *creationDateLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIView *contView;
@property (strong, nonatomic) IBOutlet UILabel *likesCountLabel;

- (IBAction)likeButtonAction:(UIButton *)sender;
- (void) setLikeButtonState:(BOOL) amILike;
- (void) setLikeLabelWithCount:(NSInteger) count;

@end
