//
//  UIViewController+CustomCatagory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>
//在controller中使用
#define selfViewSize    self.view.frame.size
#define selfViewWidth   self.view.frame.size.width
#define selfViewHeight  self.view.frame.size.height
#define selfViewXpoint  self.view.frame.origin.x
#define selfViewYpoint  self.view.frame.origin.y

@interface UIViewController (CustomCatagory)

/**
 *  在导航控制器里面获取指定VC的索引
 *
 *  @return 视图控制器索引
 */
-(NSInteger) getVCIndexInNavigationWith:(Class) viewcontroller;

/**
 *  在导航控制器中，获取指定的VC
 *
 *  @param viewController 指定VC
 *
 *  @return VC
 */
-(UIViewController *) getViewControllerInNavigationWith:(Class) viewController;

/**
 *  @brief 找出当前viewController的前面第几个ViewController
 *
 *  @param index 前面索引
 *
 *  @return 指定的viewController
 *
 *  @since 2.2.0
 */
-(UIViewController *) getViewControllerBeforeIndex:(NSInteger) index;

/**
 *  键盘通知,只有键盘将要出现，将要消失的通知
 */
-(void) registeKeyBoardNotification;

/**
 *  移除所有通知
 */
-(void) unRegisteNotification;

/**
 *  键盘将要出现时的开始边框，和最后的边框
 *
 *  @param beginRect 刚开始的边框
 *  @param endRect   结束后的边框
 */
-(void) keyBoardWillShowBegin:(CGRect) beginRect End:(CGRect) endRect;

/**
 *  键盘将要隐藏时的开始边框，和最后的边框
 *
 *  @param beginRect 刚要隐藏的边框
 *  @param endRect   隐藏完后的边框
 */
-(void) keyBoardWillHiddenBegin:(CGRect) beginRect End:(CGRect) endRect;

/**
 *  默认返回按钮
 */
-(void)WMZ_CustomNaviBackButton;
/**
 *  自定义导航条返回按钮
 *
 *  @param title 自定义标题
 */
-(void) WMZ_CustomNaviBackButton:(NSString *) title;

/**
 *  自定义导航条返回按钮,默认为下一步
 */
-(void) WMZ_CustomNaviRightButton;

/**
 *  自定义导航条返回按钮
 *
 *  @param title 自定义标题
 */
-(void) WMZ_CustomNaviLeftButton:(NSString *) title;

/**
 *  自定义返回按钮
 *
 *  @param image 返回图片
 */
-(void) WMZ_CustomNaviLeftButtonWithImage:(UIImage *) image;

/**
 *  自定义导航条返回按钮
 *
 *  @param title 自定义标题
 */
-(void) WMZ_CustomNaviRightButton:(NSString *) title;

/**
 *  图片按钮
 *
 *  @param image 图片
 */
-(void) WMZ_CustomNaviRightButtonWithImage:(UIImage *) image;

/**
 *  向导航条添加自定义按钮视图
 *
 *  @param customView 自定义按钮
 */
-(void) WMZ_CustomNaviRightButtonWithCustomView:(UIButton *) customView;

/**
 *  自定义的右边按钮点击事件
 */
-(void) WMZ_CustomNaviRightButtonClicked;

/**
 *  导航条左边按钮点击事件
 */
-(void) WMZ_CustomNaviLeftButtonClicked;
@end
