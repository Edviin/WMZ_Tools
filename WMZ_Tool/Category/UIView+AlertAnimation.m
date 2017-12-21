//
//  UIView+AlertAnimation.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UIView+AlertAnimation.h"
#import <objc/runtime.h>

#define WINDOW [[UIApplication sharedApplication] keyWindow]
#define transformScale(scale) [NSValue valueWithCATransform3D:[self transform3DScale:scale]]
#define alertKey @"alertKey"
#define dismissKey @"dismissKey"

const static char isTapBackDissmissKey;
@implementation UIView (AlertAnimation)


-(void)setIsTapBackDismiss:(BOOL)isTapBackDismiss
{
    objc_setAssociatedObject(self, &isTapBackDissmissKey, @(isTapBackDismiss), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)isTapBackDismiss
{
    return [objc_getAssociatedObject(self, &isTapBackDissmissKey) boolValue];
}

-(void)showAlerAnimation
{
    UIView *backView=[[UIView alloc] initWithFrame:WINDOW.bounds];
    backView.backgroundColor = [UIColor orangeColor];
    backView.userInteractionEnabled=YES;
    backView.tag=100000;
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.4;
    [WINDOW addSubview:backView];
    UITapGestureRecognizer *tapBack=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSome)];
    [backView addGestureRecognizer:tapBack];
    
    self.userInteractionEnabled=YES;
    self.center=backView.center;
    self.tag=100001;
    [WINDOW addSubview:self];
    
    [self animationAlert];
}

-(void)dismissAlertAnimationAndNotRemove
{
    [self hiddenWithView:self];
}
-(void)dismissAlertAnimation
{
    if (self.isTapBackDismiss)
    {
        [self tapSome];
    }
}

-(void)tapSome
{
    [self remove];
}
-(void) remove
{
    if ([WINDOW viewWithTag:100000])
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            [WINDOW viewWithTag:100000].alpha=0.0;
            [WINDOW viewWithTag:100001].alpha=0.0;
        } completion:^(BOOL finished) {
            [[WINDOW viewWithTag:100000] removeFromSuperview];
            [[WINDOW viewWithTag:100001] removeFromSuperview];
            
        }];
    }
}
-(void)hiddenWithView:(UIView *)view
{
    [UIView animateWithDuration:0.5 animations:^{
        [WINDOW viewWithTag:100000].alpha=0.0;
        [WINDOW viewWithTag:100001].alpha=0.0;
    } completion:^(BOOL finished) {
    }];
}
- (CATransform3D)transform3DScale:(CGFloat)scale
{
    CATransform3D currentTransfrom = CATransform3DScale(self.layer.transform, scale, scale, 1.0f);
    return currentTransfrom;
}
- (void)animationAlert
{
    NSArray *frameValues = @[transformScale(0.1f), transformScale(1.15f), transformScale(0.9f), transformScale(1.0f)];
    NSArray *frameTimes = @[@(0.0f), @(0.5f), @(0.9f), @(1.0f)];
    CAKeyframeAnimation *keyanimation = [self animationWithValues:frameValues times:frameTimes duration:0.4f];
    [self.layer addAnimation:keyanimation forKey:alertKey];
    [self.layer performSelector:@selector(removeAnimationForKey:) withObject:alertKey afterDelay:keyanimation.duration];
}

- (CAKeyframeAnimation *)animationWithValues:(NSArray*)values times:(NSArray*)times duration:(CGFloat)duration {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [animation setValues:values];
    [animation setKeyTimes:times];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setRemovedOnCompletion:NO];
    [animation setDuration:duration];
    
    return animation;
}
@end
