//
//  LbadCalendarView.h
//  lbad
//  行程选择日历view
//  Created by 辰 宫 on 14-7-29.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LbadCalendarDelegate <NSObject>

/*完成日期选择回调*/
- (void)selectedOn:(NSDate *)beginDate to:(NSDate *)endDate withSize:(NSInteger)size;

/*日历高度变化*/
- (void)setCalendarHigh;
- (void)setCalendarLow;

@end

@interface LbadCalendarView : UIView

/*每个月默认的日期，当月为今日，其他为每月1号*/
@property (nonatomic,strong) NSDate *defaultDate;
@property (nonatomic,weak) id<LbadCalendarDelegate> delegate;
/*保存已选中的日期*/
@property (nonatomic) NSMutableArray *selectedDateArray;

@end
