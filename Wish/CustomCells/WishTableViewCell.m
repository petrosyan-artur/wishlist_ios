//
//  WishTableViewCell.m
//  Wish
//
//  Created by Annie Klekchyan on 2/3/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "WishTableViewCell.h"
#import "Definitions.h"
#import "SignUpViewController.h"
#import "WishUtils.h"
#import "EditWishViewController.h"

@implementation WishTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if(self.pageIndex == MY_WISHES_PAGE){
        UILongPressGestureRecognizer *hold = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(contViewLongTap:)];
        [self.contView addGestureRecognizer:hold];
    }
}

-(void)contViewLongTap:(UIGestureRecognizer *)gestureRecognizer{
    
    [self becomeFirstResponder];
    CGRect targetRectangle = CGRectMake(kmainScreenWidth/2 - 50, self.contView.bounds.size.height/2 - 50, 100, 100);
    [[UIMenuController sharedMenuController] setTargetRect:targetRectangle
                                                    inView:self.contView];
    
    UIMenuItem *editMenuItem = [[UIMenuItem alloc] initWithTitle:@"Edit"
                                                      action:@selector(editAction:)];
    UIMenuItem *deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"Delete"
                                                          action:@selector(deleteAction:)];
    
    [[UIMenuController sharedMenuController]
     setMenuItems:@[editMenuItem, deleteMenuItem]];
    [[UIMenuController sharedMenuController]
     setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action
              withSender:(id)sender
{
    BOOL result = NO;
    if(@selector(copy:) == action ||
       @selector(editAction:) == action ||
       @selector(deleteAction:) == action) {
        result = YES;
    }
    return result;
}

// UIMenuController Methods

// Default copy method
- (void)copy:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.wish.content;
}

- (void)editAction:(id)sender {
    
    [self editWishWithWishObject:self.wish];
    //[self.delegate editWishWithWishObject:self.wish];
}

- (void)deleteAction:(id)sender {
    NSLog(@"Custom Action");
}

- (IBAction)likeButtonAction:(UIButton *)sender {
    
    if([WishUtils isAuthenticated]){

    }else{
        
        [WishUtils openLoginPage];
    }
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

#pragma mark - LongPressMenuDelegate

- (void) editWishWithWishObject:(WishObject *)wish{
    [self.delegate editWishWithWishObject:wish];
}

@end
