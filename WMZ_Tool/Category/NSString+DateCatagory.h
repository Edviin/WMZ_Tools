//
//  NSString+DateCatagory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *const NodeJsDateFormater;

@interface NSString (DateCatagory)

/**
 *  根据指定的日期格式，将日期字符串转换为日期,并且日期组成部分都没变化
 *
 *  @param formate 格式化字符串
 *
 *  @return 格式化后的日期
 */
-(NSDate *) dateWithFormateGMT0:(NSString *) formate;

/**
 *  只需要年月日，时间字符串,一般形式yyyy-MM-dd
 *
 *  @return 年月日字符串
 */
-(NSString *) getYYYYMMdd;

/**
 *  将nodeJs时间转换为当前时区时间
 *
 *  @return 当前时区时间
 */
-(NSDate *) nodeJsDateToUTC;
@end
