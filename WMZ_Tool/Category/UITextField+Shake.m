//
//  UITextField+Shake.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UITextField+Shake.h"

@implementation UITextField (Shake)

- (void)shake:(int)times withDelta:(CGFloat)delta
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:0.03];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval];
}

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval
{
    [UIView animateWithDuration:interval animations:^{
        self.transform = CGAffineTransformMakeTranslation(delta * direction, 0);
    } completion:^(BOOL finished) {
        if(current >= times) {
            self.transform = CGAffineTransformIdentity;
            return;
        }
        [self _shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
            andSpeed:interval];
    }];
}
//禁用密码框的copy cut...
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([self.placeholder isEqualToString:@"密码"] ||[self.placeholder isEqualToString:@"请输入密码"] ||[self.placeholder isEqualToString:@"重复输入密码"]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
        }];
    }
    return [super canPerformAction:action withSender:sender];
}
@end
