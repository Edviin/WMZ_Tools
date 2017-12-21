//
//  UIView+AutoLayout.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

/**
 *  删除指定属性的约束
 *
 *  @param attribute 属性名
 */
-(void) removeConstraintForAttribute:(NSLayoutAttribute) attribute;

/**
 *  更新当前视图的frame，在父类视图中
 *
 *  @param attribute 指定属性
 *  @param constant  常量值
 */
-(void) updateConstraintInSuperViewForAttribute:(NSLayoutAttribute) attribute constant:(CGFloat) constant;

/**
 *  在父类视图中添加指定属性常量值
 *
 *  @param attribute      属性值
 *  @param superAttribute 父类属性值
 *  @param constant       常量
 */
-(void) addConstraintFor:(NSLayoutAttribute ) attribute
      superViewAttribute:(NSLayoutAttribute) superAttribute
                constant:(CGFloat) constant;


/**
 *  更新自身视图高度的约束
 *
 *  @param height 高度
 */
-(void) updateConstraintForHeight:(CGFloat) height;

/**
 *  更新自身视图宽度的约束
 *
 *  @param width 宽度
 */
-(void) updateConstraintForWidth:(CGFloat) width;

/**
 *  更新自身视图的size尺寸约束
 *
 *  @param size 尺寸
 */
-(void) updateConstraintForSize:(CGSize) size;

/**
 *  子类视图填充到父类视图
 */
-(void) addConstraintToFillWithSuperView;

/**
 *  为自身对象添加宽度约束
 *
 *  @param width 宽度
 */
-(void) addConstraintForselfWidth:(CGFloat) width;

/**
 *  为自身对象添加宽度约束
 *
 *  @param height 宽度
 */
-(void) addConstraintForselfHeight:(CGFloat) height;
@end
