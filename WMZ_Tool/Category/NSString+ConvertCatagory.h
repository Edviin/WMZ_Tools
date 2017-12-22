//
//  NSString+ConvertCatagory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ConvertCatagory)
/**
 *  将字符串转换为数组
 *
 *  @return 数组
 */
-(NSArray *) stringToArray;


/**
 *  转换成MD5加密字符串
 *
 *  @return 加密字符串
 */
-(NSString *) toMD5String;

/**
 *  转换成32为加密字符串
 *
 *  @return 加密后的字符串
 */
-(NSString *) to32BitMD5String;



/**
 *  文本先进行DES加密。然后再转成base64
 *
 *  @param text 被加密的字符串
 *  @param key  加密的key
 *
 *  @return 加密后的字符串
 */
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key;
/**
 *  先把base64转为文本。然后再DES解密
 *
 *  @param base64 被解密的字符串
 *  @param key  加密的key
 *
 *  @return 解密后的字符串
 */

+ (NSString *)textFromBase64String:(NSString *)base64 withKey:(NSString*)key;
/**
 *  文本数据进行DES加密
 *
 *  @param data 被加密的data
 *  @param key  加密的key
 *
 *  @return 加密后的字符串
 */
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;
/**
 *  文本数据进行DES解密
 *
 *  @param data 被解密的data
 *  @param key  加密的key
 *
 *  @return 解密后的字符串
 */
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;
/**
 base64格式字符串转换为文本数据 base64解密

 @param string 被加密的string
 @return 返回解密后的data
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
/**
 文本数据转换为base64格式字符串

 @param data 需要加密的data
 @return 加密后字符串
 */
+ (NSString *)base64EncodedStringFrom:(NSData *)data;

/**
 * Base64 转字符
 */
+ (NSString *)encodedUrlParameterWithDictionary:(NSDictionary *)dict;

/**
 *  字符串转为十六进制
 *
 *  @return 哈希字符串
 */
- (NSString *)hexStringFromString;

/**
 *  十六进制转为字符串
 *
 *  @return 字符串
 */
- (NSString *)stringFromHexString;

/**
 *  根据传入的表情代码，获得包括图片真实路径的内容
 *
*
 *  @return 包括真实表情图片的内容
 */
-(NSString *) emojToRealPath;

/**
 *  判断有多少个表情图片
 *
 *  @param content 表情内容
 *
 *  @return 表情图片个数
 */
-(NSInteger) judgeEmojCount:(NSString *) content;

/**
 *  json字符串转换为字典
 *
 *  @return 字典
 */
-(NSDictionary *) jsonToDict;

/**
 *  json字符串转换为数组
 *
 *  @return 字典
 */
-(NSArray *) jsonToArray;

/**
 *  替换手机系统表情图片为空
 *
 *  @return 返回不含系统表情图片的字符串
 */
-(NSString *) stringByReplaceEmojString;

/**
 *  特殊符号的转换
 *
 *  @return 返回正常字符串
 */
- (NSString *)transformSpecialSymbolsWithString;


/**
 *  返回UUID
 *
 *  @return UUID
 */
- (NSString*) uniqueString;

/**
 *  URL 里面特殊字符进行编码
 *
 *  @return 编码后的字符串
 */
//-------------------------如果调用报错,请查看消息内部内容----------------------------------------------------
- (NSString*) urlEncodedString;

/**
 *  URL里面的特殊字符解码
 *
 *  @return 解码后的字符串
 */
//-------------------------如果调用报错,请查看消息内部内容----------------------------------------------------
- (NSString*) urlDecodedString;
/**
 *  Unicode转换为汉字
 *
 *  @param unicodeStr unicode字符串
 *
 *  @return 转换后的汉字
 */
//-------------------------如果调用报错,请查看消息内部内容----------------------------------------------------
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
@end
