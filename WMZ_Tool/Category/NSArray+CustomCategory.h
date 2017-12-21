//
//  NSArray+CustomCategory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CustomCategory)

/**
 *  将数组转换为字符串
 *
 *  @return 字符串
 */
-(NSString *) arrayToString;

/**
 *  将字符串从某个位置开始截取给定长度的字符串
 *
 *  @param location 位置
 *  @param length   长度
 *
 *  @return 字符串
 */
-(NSString *) arrayToStringFromLocation:(NSInteger) location length:(NSInteger) length;

/**
 *  将数组转换为json字符串
 *
 *  @return json字符串
 */
-(NSString *) toJsonString;
@end
