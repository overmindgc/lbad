//
//  LbadDateSelectorViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-7-29.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "LbadDateSelectorViewController.h"
#import "LbadCalendarView.h"

#define HIGH_CALENDER_HIGHT 343
#define LOW_CALENDER_HIGHT 300

@interface LbadDateSelectorViewController ()

@end

@implementation LbadDateSelectorViewController
{
    NSInteger currCalenderHight;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.smpleCalendar = [[CalendarView alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-80)];
//    self.smpleCalendar.delegate = self;
//    [self.smpleCalendar setBackgroundColor:[UIColor whiteColor]];
//    self.smpleCalendar.calendarDate = [NSDate date];
//    self.view = self.smpleCalendar;

    self.calendarView = [[LbadCalendarView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - LOW_CALENDER_HIGHT, self.view.bounds.size.width, LOW_CALENDER_HIGHT)];
    self.calendarView.delegate = self;
    [self.calendarView setBackgroundColor:[UIColor whiteColor]];
    self.view = self.calendarView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark LbadCalendarDelegates

/*完成日期选择回调*/
- (void)selectedOn:(NSDate *)beginDate to:(NSDate *)endDate withSize:(NSInteger)size
{
    //关闭动作需要再上层的弹出者进行，继续调用弹出者的代理方法
    [self.delegate selectedOn:beginDate to:endDate withSize:size];
}

/*日历高度变化*/
- (void)setCalendarHigh
{
    if (currCalenderHight != HIGH_CALENDER_HIGHT) {
        currCalenderHight = HIGH_CALENDER_HIGHT;
        //开始动画
        [UIView beginAnimations:nil context:nil];
        //设定动画持续时间
        [UIView setAnimationDuration:0.2f];
        //动画的内容
        self.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - HIGH_CALENDER_HIGHT, self.view.bounds.size.width, HIGH_CALENDER_HIGHT);
        //动画结束
        [UIView commitAnimations];
    }
}

- (void)setCalendarLow
{
    if (currCalenderHight != LOW_CALENDER_HIGHT) {
        currCalenderHight = LOW_CALENDER_HIGHT;
        //开始动画
        [UIView beginAnimations:nil context:nil];
        //设定动画持续时间
        [UIView setAnimationDuration:0.2f];
        //动画的内容
        self.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - LOW_CALENDER_HIGHT, self.view.bounds.size.width, LOW_CALENDER_HIGHT);
        //动画结束
        [UIView commitAnimations];
    }
}
@end
