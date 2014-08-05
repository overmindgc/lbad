//
//  LbadDateSelectorViewController.h
//  lbad
//  行程选择日历controller
//  Created by 辰 宫 on 14-7-29.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LbadCalendarView.h"

@interface LbadDateSelectorViewController : UIViewController <LbadCalendarDelegate>

@property(nonatomic,strong) LbadCalendarView *calendarView;

@property (nonatomic,weak) id<LbadCalendarDelegate> delegate;

@end
