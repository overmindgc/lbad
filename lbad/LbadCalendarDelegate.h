//
//  LbadCalendarDelegate.h
//  lbad
//
//  Created by 辰 宫 on 14-8-4.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LbadCalendarDelegate <NSObject>

/*完成日期选择回调*/
- (void)selectedOn:(NSDate *)beginDate to:(NSDate *)endDate withSize:(NSInteger)size;

@optional
/*日历高度变化*/
- (void)setCalendarHigh;
- (void)setCalendarLow;

@end
