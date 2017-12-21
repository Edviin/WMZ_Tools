//
//  UITextField+Shake.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Shake)
/**
 *  文本框抖动
 *
 *  @param times 抖动的次数
 *  @param delta 抖动的偏移量
 */
- (void)shake:(int)times withDelta:(CGFloat)delta;
/**
 *  文本框抖动
 *
 *  @param times    抖动的次数
 *  @param delta    抖动的偏移量
 *  @param interval 整个抖动的执行时间
 */
- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval;

@end
