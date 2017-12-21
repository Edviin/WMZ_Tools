//
//  NSDictionary+CustomCategory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CustomCategory)

/**
 *  将字典转换为json字符串
 */
-(NSString *) dictToJson;

/**
 *  键值对反转
 *
 *  @return 新的dict
 */
-(NSDictionary *) keysAndValuesReverse;
@end
