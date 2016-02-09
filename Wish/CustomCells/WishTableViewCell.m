//
//  WishTableViewCell.m
//  Wish
//
//  Created by Annie Klekchyan on 2/3/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "WishTableViewCell.h"
#import "Definitions.h"

@implementation WishTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)likeButtonAction:(UIButton *)sender {
    
}

- (void) setLikeButtonState:(BOOL) amILike{
    
    if(amILike){
        
        [self.likeButton setImage:likedImageIcone forState:UIControlStateNormal];
    }else{
        
        [self.likeButton setImage:likeImageIcone forState:UIControlStateNormal];
    }
}

- (void) setLikeLabelWithCount:(NSInteger) count{
    
    if(count > 0){
        
        self.likesCountLabel.text = [NSString stringWithFormat:@"%d", count];
        self.likesCountLabel.hidden = NO;
    }else{
        
        self.likesCountLabel.hidden = YES;
    }
}

@end
