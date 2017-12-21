//
//  NSDictionary+CustomCategory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "NSDictionary+CustomCategory.h"

@implementation NSDictionary (CustomCategory)

/**
 *  将字典转换为json字符串
 *
 *  @return json字符串
 */
-(NSString *) dictToJson{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (error) {
        return @"";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];;
}

-(NSDictionary *) keysAndValuesReverse{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSString *text in self) {
        [dict setObject:text forKey:[self objectForKey:text]];
    }
    return dict;
}
@end
