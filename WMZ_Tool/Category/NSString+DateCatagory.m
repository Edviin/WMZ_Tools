//
//  NSString+DateCatagory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "NSString+DateCatagory.h"
NSString *const NodeJsDateFormater = @"yyyy-MM-dd'T'HH:mm:ss.SSZ";

@implementation NSString (DateCatagory)
-(NSDate *)dateWithFormateGMT0:(NSString *)formate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [dateFormatter setDateFormat:formate];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

//只需要年月日
-(NSString *) getYYYYMMdd{
    return (self.length > 10) ? [self substringToIndex:10] : @"";
}

#pragma mark -
#pragma mark 当前时区的时间
-(NSDate *) nodeJsDateToUTC{
    return [self dateWithFormateGMT0:NodeJsDateFormater];
}

@end
