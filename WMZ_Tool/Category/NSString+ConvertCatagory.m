//
//  NSString+ConvertCatagory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "NSString+ConvertCatagory.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@implementation NSString (ConvertCatagory)
/**
 *  字符串转换为数组
 *
 *  @return 数组
 */
-(NSArray *) stringToArray{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < self.length; i ++) {
        [array insertObject:[NSString stringWithFormat:@"%C",[self characterAtIndex:i]] atIndex:i];
    }
    return array;
}

/**
 *  根据传入的表情代码，获得包括图片真实路径的内容,表情代码格式[emo:001]
 *
 *  @param emojCode 表情代码
 *
 *  @return 包括真实表情图片的内容
 */
-(NSString *) emojToRealPath{
    if (self.length == 0) {
        return nil;
    }
    //读取属性文件
    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"emoj" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:bundle];
    NSString *changeString = @"";
    NSUInteger startLocation = 0;
    
    //表情的匹配格式
    NSString *regTags = @"\\[[\u4e00-\u9fa5]{0,}\\]";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionUseUnicodeWordBoundaries// 还可以加一些选项，例如：不区分大小写
                                                                             error:&error];
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:self
                                      options:0
                                        range:NSMakeRange(0, [self length])];
    // 用下面的办法来遍历每一条匹配记录
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        //现将图片前面部分匹配
        changeString = [changeString stringByAppendingString: [self substringWithRange:NSMakeRange(startLocation, matchRange.location - startLocation)]];
        NSString *imagePath = [NSString stringWithFormat:@"<img src='%@'>",[dict objectForKey:[self substringWithRange:matchRange]]];
        changeString = [changeString stringByAppendingString:imagePath];//这里要写成对应的目的路径
        startLocation = matchRange.length + matchRange.location;
    }
    //将最后一张图片的文字部分补充上
    if (startLocation != self.length) {
        changeString = [changeString stringByAppendingString:[self substringWithRange:NSMakeRange(startLocation, self.length - startLocation)]];
    }
    return changeString;
}

/**
 *  判断有多少个表情图片
 *
 *  @param content 表情内容
 *
 *  @return 表情图片个数
 */
-(NSInteger) judgeEmojCount:(NSString *) content{
    if (!content) {
        return 0;
    }
    NSString *regTags =  @"\\[[\u4e00-\u9fa5]{0,}\\]";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive// 还可以加一些选项，例如：不区分大小写
                                                                             error:&error];
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:content
                                      options:0
                                        range:NSMakeRange(0, [content length])];
    return matches.count;
}



//MD5加密
-(NSString *) toMD5String{
    const char *str = [self UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *md5String = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return md5String;
}

-(NSString *) to32BitMD5String{
    const char *cStr = [self UTF8String];
    if (cStr == NULL) {
        cStr = "";
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

//文本先进行DES加密。然后再转成base64
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key
{
    if (text && ![text isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin
        data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return @"";
    }
}

//先把base64转为文本。然后再DES解密
+ (NSString *)textFromBase64String:(NSString *)base64 withKey:(NSString*)key
{
    if (base64 && ![base64 isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin
        data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return @"";
    }
}


/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
    return nil;
    if ([string length] == 0)
    return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
        return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
        decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
    return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
    return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
            break;
            if (isspace(characters[i]) || characters[i] == '=')
            continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
        break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
        bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
        bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
    return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
    return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
        buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
        characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
        characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}



#pragma mark -
#pragma mark Base64 转字符
+ (NSString *)encodedUrlParameterWithDictionary:(NSDictionary *)dict {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject: dict options: 0 error: &error];
    NSString *jsonString = [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString: @"\\" withString: @""];
    
    NSData *data = [jsonString dataUsingEncoding: NSUTF8StringEncoding];
    NSString *baseString = [data base64EncodedStringWithOptions: 0];
    baseString = [baseString stringByReplacingOccurrencesOfString: @"+" withString: @"-jia-"];
    
    return baseString;
}


#pragma mark -
#pragma mark 十六进制与字符串之间的转换

//字符串转十六进制
- (NSString *)hexStringFromString{
    NSAssert(!self, @"十六进制转字符串中，字符串不能为空");
    
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSData *myData = [self dataUsingEncoding:gbkEncoding];
    Byte *bytes = (Byte *)[myData bytes];
    
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(NSInteger index = 0;index < myData.length; index++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[index]];///16进制数
        if([newHexStr length]==1)
        hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
        hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

//十六进制转字符串
- (NSString *)stringFromHexString {
    NSAssert(!self, @"字符串转十六进制中，字符串不能为空");
    
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    char *myBuffer = (char *)malloc((NSInteger)[self length] / 2 + 1);
    bzero(myBuffer, [self length] / 2 + 1);
    
    for (NSInteger index = 0; index < [self length] - 1;index += 2) {
        
        unsigned int  anInt;
        NSString * hexCharStr = [self substringWithRange:NSMakeRange(index, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[index / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:gbkEncoding];
    return unicodeString;
}

//json字符串转换为字典
-(NSDictionary *) jsonToDict{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (error) {
        return nil;
    }
    return dict;
}

//json到数组
-(NSArray *) jsonToArray{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingMutableContainers
                                                       error:&error];
    if (error) {
        
        return nil;
    }
    return array;
}

//替换表情字符串
-(NSString *) stringByReplaceEmojString{
    NSError *error;
    
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:&error];
    
    //如果有错，则直接返回空字符串
    if (error) {
        return @"";
    }
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:self
                                      options:0
                                        range:NSMakeRange(0, [self length])];
    //没有表情字符串，则直接返回当前字符串
    if (matches.count == 0) {
        return self;
    }
    
    // 用下面的办法来遍历每一条匹配记录
    NSString *replaceString = @"";
    NSInteger startLocation = 0;
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        //现将图片前面部分匹配
        replaceString = [replaceString stringByAppendingString: [self substringWithRange:NSMakeRange(startLocation, matchRange.location - startLocation)]];
        startLocation = matchRange.length + matchRange.location;
    }
    
    //将最后的文字部分补充上
    if (startLocation != self.length) {
        replaceString = [replaceString stringByAppendingString:[self substringWithRange:NSMakeRange(startLocation, self.length - startLocation)]];
    }
    return replaceString;
}

// 特殊符号的转换
- (NSString *)transformSpecialSymbolsWithString{
    NSString *returnString = [NSString stringWithString:self];
    
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#34;" withString:@" "" "];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#40;" withString:@"("];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#41;" withString:@")"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#44;" withString:@","];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#47;" withString:@"/"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#58;" withString:@":"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#91;" withString:@"["];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#92;" withString:@"//"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#93;" withString:@"]"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#123;" withString:@"{"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#125;" withString:@"}"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#lt;" withString:@"<"];
    returnString = [returnString stringByReplacingOccurrencesOfString:@"&#gt;" withString:@">"];
    
    return  returnString;
}
- (NSString*) uniqueString
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);
    //    NSString    *uuidString = ( NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    NSString    *uuidString = CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}
- (NSString*) urlEncodedString {
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          ( CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    //  NSString *encodedString = [[NSString alloc] initWithString:( NSString*) encodedCFString];
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge NSString*) encodedCFString];
    CFRelease(encodedCFString);
    
    if(!encodedString)
    encodedString = @"";
    
    return encodedString;
    
}

- (NSString*) urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          ( CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge NSString*) decodedCFString];
    CFRelease(decodedCFString);
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *retrunStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    
    
    return [retrunStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
    
    
}
@end
