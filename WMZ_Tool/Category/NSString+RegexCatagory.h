//
//  NSString+RegexCatagory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegexCatagory)

/**
 *  字母开头，允许5-20字节，允许字母数字下划线
 *
 *  @return BOOL
 */
- (BOOL)isAccount;

/**
 *  判断是不是电话号码
 *
 *  @return 返回失败或者成功
 */
-(BOOL) isTelephoneNumber;

/**
 *  判断是不是全是数字
 *
 *  @return 返回成功或失败
 */
-(BOOL) isAllNumber;

/**
 * 纯数字或带有中划线
 *
 *  @return BOOL
 */
- (BOOL)isAllNumberOrLine;

/**
 纯数字以及小数点
 */

- (BOOL) isOnlyNumberOrPoint;

/**
 * 是否是中文
 *
 *  @return BOOL
 */
- (BOOL)isChinese;

/**
 *  数字验证码 6位
 *
 *  @return BOOL
 */
- (BOOL)isNumSecurityCode;


/**
 *  限制数字只能为好多位
 *
 *  @return 返回成功或失败
 */
-(BOOL) isLimitNumber:(NSUInteger) limit;

/**
 *  判断是不是邮箱
 *
 *  @return 返回成功或失败
 */
-(BOOL) isEamilAddress;

/**
 *  判断是不是车牌号
 *
 *  @return 返回成功或失败
 */
-(BOOL) isCarNumber;

/**
 *  判断是否是邮政编码
 *
 *  @return 返回成功或失败
 */
-(BOOL) isEMSCode;

/**
 *  验证密码时包含数字字母,是否同时包含数字和字母
 *
 *  @param start 至少位数
 *  @param stop  至多位数
 *
 *  @return 校验成功或失败
 */
-(BOOL) isPasswordIncludeWordAndNumberLimit:(NSUInteger) start
                                       stop:(NSUInteger) stop;

/**
 *  身份证号码验证
 *
 *  @return 验证结果
 */
- (BOOL)isValidateIdCardNumber;

/**
 *  验证是否包含空格
 *
 *  @return 验证是否正确
 */
-(BOOL)isValidateBlank;
@end
