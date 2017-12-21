//
//  UIView+AlertAnimation.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AlertAnimation)

/**
 *  是否在点击空白区域的时候要消失 默认为NO
 */
@property (nonatomic,assign) BOOL isTapBackDismiss;

/**
 *  以AlertView动画显示某个View
 */
-(void) showAlerAnimation;

/**
 *  动画完后手动消失某个View
 */
-(void) dismissAlertAnimation;

/**
 *  收到将某个View的AlertView动画隐藏,并且不从父视图移除
 */
-(void) dismissAlertAnimationAndNotRemove;


@end
