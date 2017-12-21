//
//  NSDate+CustomCategory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926

@interface NSDate (CustomCategory)

- (NSString *)timeIntervalDescription;//距离当前的时间间隔描述
- (NSString *)minuteDescription;/*精确到分钟的日期描述*/
- (NSString *)formattedTime;
- (NSString *)formattedDateDescription;//格式化日期描述
- (double)timeIntervalSince1970InMilliSecond;
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;
+ (NSString *)formattedTimeFromTimeInterval:(long long)time;
// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;
- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursBettweenDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger) daysBettweenDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;


/**
 *  向指定的日期添加年数
 *
 *  @param years 年数
 *
 *  @return 新的日期
 */
-(NSDate *) dateByAddYears:(NSInteger) years;

/**
 *  将GMT标准时间，转换为当前时区的时间
 *
 *  @return 当前时区的时间
 */
-(NSDate *) currentTimeZoneDate;

/**
 *  根据给出时间，时间单元
 *
 *  @param unit 时间单元
 *
 *  @return 返回时间单元对应的值
 */
-(NSInteger) getUnit:(NSCalendarUnit)unit;

/**
 *  根据日期判断是星期几
 *
 *  @return 返回星期几
 */
-(NSString *) getWeakDay;

/**
 *  计算当年日期和指定日期的间隔年数
 *
 *  @param otherDate 指定日期
 *
 *  @return 间隔年数
 */
-(NSInteger) caculateYearIntevalWith:(NSDate *) otherDate;

/**
 *  将日期转换为指定日期格式
 *
 *  @param formate 指定格式的日期
 *
 *  @return 格式化后的字符串
 */
-(NSString *) dateToStringWithFormate:(NSString *) formate;

/**
 *  将日期转化为时区为格林威治时间,这种格式相当于字符串和日期中对应的部分都不变
 *
 *  @param formate 格式字符串
 *
 *  @return 日期字符串
 */
-(NSString *) dateToGMT0StringWithFormate:(NSString *) formate;

/**
 *  获取当前时区与标准时区的间隔
 *
 *  @return 间隔
 */
-(NSInteger) getCurrentTimeZoneInteval;

/**
 *  获取真正的时间描述(与服务端一致)
 *
 *  @return 时间描述
 */
-(NSString *) systemServerTimeIntervalDescription;
@end
