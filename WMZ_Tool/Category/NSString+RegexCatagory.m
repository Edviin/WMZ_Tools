//
//  NSString+RegexCatagory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "NSString+RegexCatagory.h"

@implementation NSString (RegexCatagory)

- (BOOL)isAccount{
    NSString *regexString = @"^[a-z|A-Z][\\w]{4,19}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [predicate evaluateWithObject:self];
}


//判断电话号码
-(BOOL) isTelephoneNumber{
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

//判断是不是全是数字
-(BOOL ) isAllNumber{
    NSString *allNumberRegex = @"^[0-9]*$";
    NSPredicate *allNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", allNumberRegex];
    return [allNumberTest evaluateWithObject:self];
    
}

- (BOOL)isAllNumberOrLine
{
    NSString *regexString = @"^[0-9-]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [predicate evaluateWithObject:self];
}

-(BOOL)isOnlyNumberOrPoint
{
    //    if ([self isEqualToString:@""])
    //    {
    //        return YES;
    //    }
    //    if ([self isEqualToString:@"00"])
    //    {
    //        return NO;
    //    }
    //    if ([self isEqualToString:@"0.0"])
    //    {
    //        return NO;
    //    }
    NSString *regexString = @"^[0-9]+\\.?[0-9]{0,2}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isChinese
{
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
        
    }
    return NO;
}


- (BOOL)isNumSecurityCode{
    NSString *regexString = @"^[0-9]{6}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [predicate evaluateWithObject:self];
}

//限制数字只能为好多位
-(BOOL) isLimitNumber:(NSUInteger) limit{
    NSString *limitRegex = [NSString stringWithFormat:@"^\\d{%@}$",@(limit)];
    NSPredicate *limitTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", limitRegex];
    return [limitTest evaluateWithObject:self];
}
//判断是不是邮箱
-(BOOL) isEamilAddress{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//判断是不是车牌号
-(BOOL) isCarNumber{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}

//验证是否包含规定范围的字母或数字
-(BOOL) isPasswordIncludeWordAndNumberLimit:(NSUInteger)start
                                       stop:(NSUInteger)stop{
    
    NSString *wordRegex = [NSString stringWithFormat:@"^(?!(?:[^a-zA-Z]|\\D|[a-zA-Z0-9])$).{%@,%@}$",@(start),@(stop)];
    NSPredicate *wordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",wordRegex];
    return [wordTest evaluateWithObject:self];
}

//验证是否是邮政编码
-(BOOL) isEMSCode{
    NSString *wordRegex = @"^[1-9][0-9]{5}$";
    NSPredicate *wordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",wordRegex];
    return [wordTest evaluateWithObject:self];
}

- (BOOL)isValidateIdCardNumber
{
    if (self == nil || [self isEqualToString:@""]) {
        return NO;
    }
    if (self.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[self substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[self substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[self substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}
-(BOOL)isValidateBlank{
    if (self == nil || [self isEqualToString:@""]) {
        return NO;
    }
    NSCharacterSet *characterset = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if ([[self stringByTrimmingCharactersInSet:characterset] isEqualToString:@""]) {
        return YES;
    }else {
        return NO;
    }
}
@end
