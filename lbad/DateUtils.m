//
//  DateUtils.m
//  lbad
//
//  Created by 辰 宫 on 14-7-30.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

//date根据formatter转换成string
+(NSString*)dateToString:(NSString *)formatter date:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return[dateFormatter stringFromDate:date];
}

//string类型的时间戳转换成时间
+(NSString*)dateStringToString:(NSString *)dateStr
{
    if ([dateStr isKindOfClass:[NSNull class]]) {
        return nil;
    } else {
        NSInteger time = [dateStr intValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSString *timestr = [NSString stringWithFormat:@"%@",date];
        NSRange rang;
        rang.location = 0;
        rang.length = 10;
        NSString *needtime = [timestr substringWithRange:rang];
        return needtime;
    }
}

//将日期从原格式转换成需要的格式
+(NSString*)convertDateFormatter:(NSString*)sourceFormatter targetFormatter:(NSString*)targetFormatter dateString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:sourceFormatter];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:targetFormatter];
    return[dateFormatter stringFromDate:date];
}

//将日期字符串转换成date
+(NSDate *)stringToDate:(NSString *)formatter dateString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:dateString];
}

@end
