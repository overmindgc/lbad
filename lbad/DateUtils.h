//
//  DateUtils.h
//  lbad
//
//  Created by 辰 宫 on 14-7-30.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

//date根据formatter转换成string
+(NSString*)dateToString:(NSString *)formatter date:(NSDate *)date;

//string类型的时间戳转换成时间
+(NSString*)dateStringToString:(NSString *)dateStr;

//将日期从原格式转换成需要的格式
+(NSString*)convertDateFormatter:(NSString*)sourceFormatter targetFormatter:(NSString*)targetFormatter dateString:(NSString*)dateString;

//将日期字符串转换成date
+(NSDate *)stringToDate:(NSString *)formatter dateString:(NSString *)dateString;

@end
