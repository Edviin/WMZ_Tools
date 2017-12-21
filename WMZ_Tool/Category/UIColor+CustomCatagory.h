//
//  UIColor+CustomCatagory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomCatagory)
/**
 *  获取自定义的颜色，主要就是不必每次都除以255.0
 *
 *  @param red   红色
 *  @param green 绿色
 *  @param blue  蓝色
 *  @param alpha 透明度
 *
 *  @return 返回颜色值
 */
+(UIColor *) customColorWithRed:(float) red green:(float) green blue:(float) blue alpha:(float) alpha;


+ (UIColor *)customColorNameWithString:(NSString *)stringToConvert;
@end
