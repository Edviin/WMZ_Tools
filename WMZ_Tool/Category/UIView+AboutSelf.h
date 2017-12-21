//
//  UIView+AboutSelf.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AboutSelf)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

/**
 *  设置边框及颜色
 *
 *  @param borderColor 颜色
 *  @param width       宽度
 */
-(void) CustomUI_setBorderColor:(UIColor *) borderColor with:(CGFloat) width;

/**
 *  @brief 移除边框颜色
 *
 *  @since 2.0.0
 */
-(void) removeBorderColor;


/**
 *  设置圆角
 *
 *  @param radios 圆角大小
 */
-(void) CustomUI_setCornerWith:(CGFloat) radios;


/**
 *  设置阴影四周边框
 *
 *  @param offset 间距值
 */
-(void) ZJ_SetShadowPathRound:(CGFloat) offset;

/**
 *  截屏
 *
 *   全图
 *
 *  @return 截屏后的图片
 */
-(UIImage *) takeViewShot;

/**
 *  获取当前View所在的UINavigationController
 *
 *  @return UINavigationController 对象
 */
- (UINavigationController *)navigationController;

/**
 *  获取当前View所在的ViewController对象
 *
 *  @return UIViewController 对象
 */
- (UIViewController *) viewController;

/**
 *  @brief 从xib中加载view视图
 *
 *  @return view视图实例
 *
 *  @since 1.0
 */
+(id ) loadCurrentViewFromNib;


/**
 *  移除所有子视图
 */
-(void) RemoveAllSubViews;

/**
 *  移除指定的子类视图
 *
 *  @param tag 子视图的tag
 */
-(void) RemoveSubview:(NSUInteger) tag;


@end
