//
//  UIImage+CustomCatagory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CustomCatagory)

/**
 *  将图片旋转给定的角度
 *
 *  @param degrees 角度，正数代表反时针，负数代表顺时针
 *
 *  @return 旋转后的图片
 */
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  根据给定的高度来确定图片的新尺寸
 *
 *  @param height 高度
 *
 *  @return 变化后的图片
 */
-(CGSize) imageGetSizeWithHeight:(CGFloat) height;

/**
 *  根据给定的宽度来确定图片的新尺寸
 *
 *  @param width 宽度
 *
 *  @return 变化后的图片
 */
-(CGSize) imageGetSizeWithWidth:(CGFloat) width;

/**
 *  获取最合适size区域的图片尺寸,(如，宽，高，都不能超过指定size的宽高)
 *
 *  @param size 指定size
 *
 *  @return 最佳尺寸
 */
-(CGSize) imageFillSizeWithRect:(CGSize) size;
#pragma mark -
#pragma mark 图片截取相关
/**
 *  图片放大缩小
 *
 *  @param scale 放大缩小倍数
 *
 *  @return 放大缩小后的图片
 */
-(UIImage *) getImageWithScale:(float) scale;

/**
 *  截取图片中某块区域
 *
 *  @param rect 截取区域
 *
 *  @return 指定区域的图片
 */
-(UIImage *) takeSubImagewithRect:(CGRect) rect;

/**
 *  切取圆形图片，指定区域的圆形
 *
 *  @param start  圆心
 *  @param radius 半径
 *
 *  @return 切取后的图片
 */
-(UIImage *) takeArcImageWithStart:(CGPoint) start widthRadius:(CGFloat) radius;

/**
 *  截取图片中心点，指定半径的图片
 *
 *  @param radius 指定半径
 *
 *  @return 图片
 */
-(UIImage *) takeArcImageWithRadius:(CGFloat) radius;

#pragma mark -
#pragma mark 图片，颜色相关
/**
 *  绘制颜色的背景图片
 *
 *  @param color 颜色
 *  @param size  边框
 *
 *  @return 返回新的图片
 */
+(UIImage *) imageWithColor:(UIColor *) color size:(CGSize) size;

/**
 *  为图片着色
 *
 *  @param color     颜色
 *  @param blendMode 混合模式
 *
 *  @return 新的图片
 */
-(UIImage *) tintColorWith:(UIColor *) color blendMode:(CGBlendMode) blendMode;

/**
 *  图片中某一像素的颜色值
 *
 *  @param point 像素点的位置
 *
 *  @return 颜色值
 */
-(UIColor *) imagePixelColorWithPoint:(CGPoint) point;

/**
 *  将图片压缩至最大指定Data字节数
 *
 *  @param maxLength 指定字节数
 *
 *  @return nsdata
 */
-(NSData *) imageCompressWithDataMaxLength:(NSUInteger) maxLength;

/**
 *  图片毛玻璃算法
 *
 *  @param blur 毛玻璃等级
 *
 *  @return 毛玻璃图片，如果有错误，则直接返回本图片
 */
-(UIImage *) blurryImageWithBlurLevel:(CGFloat)blur;
@end
