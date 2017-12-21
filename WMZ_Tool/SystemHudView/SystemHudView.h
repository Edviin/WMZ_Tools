//
//  SystemHudView.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SystemHudView : NSObject

/**
 *  提示器的单例
 *
 *  @return 提示器单例
 */
+(instancetype) sharedInstance;

/**
 *  显示等待提示
 *
 *  @param title 等待提示文字
 */
-(void) showWaitHudViewWithTitle:(NSString *) title;

/**
 *  显示成功提示
 *
 *  @param title 成功提示文字
 */
-(void) showSuccessHudViewWithTitle:(NSString *) title;



/**
 *  显示失败提示
 *
 *  @param title 失败提示文字
 */
-(void) showFailedHudViewWithTitle:(NSString *) title;

/**
 *  @brief 自定义显示提示信息
 *
 *  @param image 图片,尺寸为74*74，111*111，正方形尺寸
 *  @param title 文字
 *
 *  @since 2.0.0
 */
-(void) showCustomHudViewWithImage:(UIImage *) image title:(NSString *) title;

/**
 *  隐藏指示器
 */
-(void) hideHUDView;
/**
 *  隐藏提示器
 *
 *  @param animated 隐藏是否有动画
 */
-(void) hideHUDViewWithAnimated:(BOOL) animated;

/**
 *  延迟隐藏指示器
 *
 *  @param delay 延迟时间
 */
-(void) hideHUDViewAfterDelay:(NSTimeInterval) delay;

/**
 *  延迟时间隐藏指示器,同时执行某个block
 *
 *  @param delay     延迟时间
 *  @param competion 执行方法
 */
-(void) hideHUDViewAfterDelay:(NSTimeInterval)delay
                  excuteBlock:(void (^)(void)) competion;


/**
 *  @brief 显示一小段文字，然后隔一分钟后消失
 *
 *  @param title 文字内容
 *
 *  @since 1.0
 */
-(void) showToastViewWithTitle:(NSString *) title;

/**
 *  @brief 显示一小段文字，隔一分钟后消失并执行block
 *
 *  @param title     文字内容
 *  @param competion 完成的block
 *
 *  @since <#1.0#>
 */
-(void) showToastViewWithTitle:(NSString *)title
               completionBlock:(void (^)(void)) competion;
@end
