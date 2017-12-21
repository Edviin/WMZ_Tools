//
//  UIView+ActionSheetAnimation.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  注意在用的时候当前View的高度必须是已经确定了的才行
 */
@interface UIView (ActionSheetAnimation)

/**
 *  是否在点击空白区域的时候要消失 默认为NO
 */
@property (nonatomic,assign) BOOL isTapBackDismiss;

/**
 *  将当前View以ActionSheet动画显示出来
 */
-(void) showActionSheetAnimation;

/**
 *  消失当前View
 */
-(void)dismiss;

@end
