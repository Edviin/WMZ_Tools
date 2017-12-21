//
//  NSString+AttributeStringCatagory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (AttributeStringCatagory)

/**
 *  将字符串转换为属性字符串，注意ranges中的顺序一定要和attributes一致
 *
 *  @param ranges 属性字符串范围
 *  @param attributes  属性设定数组
 *
 *  @return 属性字符串
 */
-(NSAttributedString *) toAttributedStringWithRanges:(NSArray *) ranges
                                          attributes:(NSArray *) attributes;
/**
 *  将字符串转换为属性字符串，同时指定每处range的字体颜色
 *
 *  @param ranges 属性字符串范围
 *  @param color  字体颜色
 *
 *  @return 属性字符串
 */
-(NSAttributedString *) toAttributedStringWithRanges:(NSArray *) ranges
                                           textColor:(UIColor *) color;
@end
