//
//  NSNumber+CustomCategory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (CustomCategory)
/**
 *  @brief 人民币数字封装了  人民币符号，number必须是以分为单位
 *
 *  @return 人民币
 *
 *  @since 1.0.0
 */
-(NSString *) priceCNYValue;

/**
 *  @brief 人民币不包含人民币符号，number必须是以分为单位
 *
 *  @return 人民币
 *
 *  @since 1.0.0
 */
-(NSString *) priceValue;

@end
