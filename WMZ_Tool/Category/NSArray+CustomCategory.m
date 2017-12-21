//
//  NSArray+CustomCategory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "NSArray+CustomCategory.h"

@implementation NSArray (CustomCategory)
-(NSString *) arrayToString{
    NSString *arrayString = @"";
    if (self.count > 0) {
        for (int i = 0; i < self.count; i ++) {
            arrayString = [arrayString stringByAppendingString:[self objectAtIndex:i]];
        }
    }
    return arrayString;
}

-(NSString *) arrayToStringFromLocation:(NSInteger) location length:(NSInteger) length{
    NSString *arrayString = @"";
    if ((location + length) < self.count) {
        for (NSInteger i = location; i < location + length; i ++) {
            arrayString = [arrayString stringByAppendingString:[self objectAtIndex:i]];
        }
    }
    return arrayString;
}


/**
 *  将数组转换为json字符串
 *
 *  @return json字符串
 */
-(NSString *) toJsonString{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (error) {
        
        return @"";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];;
}
@end
