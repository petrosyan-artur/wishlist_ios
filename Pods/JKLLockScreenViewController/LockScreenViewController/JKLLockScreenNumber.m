//
//  JKLLockScreenNumber.m
//

#import "JKLLockScreenNumber.h"

static const CGFloat LSNContextSetLineWidth = 0.8f;

@implementation JKLLockScreenNumber

- (void)setHighlighted:(BOOL)highlighted {
    if (super.highlighted != highlighted) {
        super.highlighted = highlighted;
        
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat height = CGRectGetHeight(rect);
    CGRect  inset  = CGRectInset(CGRectMake(0, 0, height, height), 1, 1);

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *color = [UIColor colorWithRed:0 green:110/255.0f blue:145/255.0f alpha:1];
    CGColorRef colorRef  = color.CGColor;//[self tintColor].CGColor;
    UIControlState state = [self state];

    CGContextSetLineWidth(context, LSNContextSetLineWidth);
    if (state == UIControlStateHighlighted) {
        CGContextSetFillColorWithColor(context, colorRef);
        CGContextFillEllipseInRect (context, inset);
        CGContextFillPath(context);
    }
    else {
        CGContextSetStrokeColorWithColor(context, colorRef);
        CGContextAddEllipseInRect(context, inset);
        CGContextStrokePath(context);
    }
}

@end
