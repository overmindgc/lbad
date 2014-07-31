//
//  LbadCalendarView.m
//  lbad
//
//  Created by 辰 宫 on 14-7-29.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "LbadCalendarView.h"
#import "LbadDateSquare.h"
#import "Consts.h"
#import "DateUtils.h"

#define columns 7
#define squareWidth 45
#define originX 3
#define originY 30

@implementation LbadCalendarView
{
    NSCalendar *gregorian;
    NSArray *_weekNames;
    NSDate *nowDate;//保存当前日期（0点计算）
}

@synthesize selectedDateArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //保存初始的日期（转化为0点）
        nowDate = [DateUtils stringToDate:@"yyyy-MM-dd" dateString:[DateUtils dateToString:@"yyyy-MM-dd" date:[NSDate date]]];
        self.defaultDate = nowDate;
        
        selectedDateArray = [[NSMutableArray alloc] initWithObjects:[DateUtils stringToDate:@"yyyy-MM-dd" dateString:@"2014-07-30"],nil];
        
        UISwipeGestureRecognizer * swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
        swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeleft];
        UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self setCalendarParameters];
    _weekNames = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.defaultDate];
    //    _selectedDay  =components.day;
    components.day = 1;
    NSDate *firstDayOfMonth = [gregorian dateFromComponents:components];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    int weekday = [comps weekday];
    //      NSLog(@"components%d %d %d",_selectedDay,_selectedMonth,_selectedYear);
    weekday = weekday - 2;
    
    if(weekday < 0)
        weekday += 7;
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self.defaultDate];
    NSInteger monthLength = days.length;
    
    //创建月份标签
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(35,8, 90, 30)];
    titleText.textAlignment = NSTextAlignmentCenter;
    NSString *dateString = [DateUtils dateToString:@"yyyy年MM月" date:self.defaultDate];
    [titleText setText:dateString];
    [titleText setFont:[UIFont fontWithName:[Consts sharedInstance].fontName size:16.0f]];
    [titleText setTextColor:[UIColor brownColor]];
    [self addSubview:titleText];
    
    //翻页按钮
    UIImage *leftImg = [UIImage imageNamed:@"left.png"];
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 13, 20, 20)];
    [leftBtn setImage:leftImg forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    
    UIImage *rightImg = [UIImage imageNamed:@"right.png"];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(123, 13, 20, 20)];
    [rightBtn setImage:rightImg forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    
    //创建确定按钮
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 8, 50, 30)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[Consts sharedInstance].mainColor forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
    [doneBtn.titleLabel setFont:[UIFont fontWithName:[Consts sharedInstance].fontName size:18.0f]];
    [doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneBtn];
    
    //创建星期文字
    for (int i =0; i<_weekNames.count; i++) {
        UIButton *weekNameLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        weekNameLabel.titleLabel.text = [_weekNames objectAtIndex:i];
        [weekNameLabel setTitle:[_weekNames objectAtIndex:i] forState:UIControlStateNormal];
        [weekNameLabel setFrame:CGRectMake(originX+(squareWidth*(i%columns)), originY + 10, squareWidth, squareWidth - 10)];
        [weekNameLabel setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [weekNameLabel.titleLabel setFont:[UIFont fontWithName:[Consts sharedInstance].fontName size:14.0f]];
        weekNameLabel.userInteractionEnabled = NO;
        [self addSubview:weekNameLabel];
    }

    
    //创建当月格子
    for (NSInteger i= 0; i<monthLength; i++)
    {
        LbadDateSquare *dateSq = [LbadDateSquare buttonWithType:UIButtonTypeCustom];
        dateSq.tag = i+1;
        dateSq.titleLabel.text = [NSString stringWithFormat:@"%ld",i+1];
        [dateSq setTitle:[NSString stringWithFormat:@"%ld",i+1] forState:UIControlStateNormal];
        NSInteger offsetX = (squareWidth*((i+weekday)%columns));
        NSInteger offsetY = (squareWidth *((i+weekday)/columns));
        [dateSq setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, squareWidth, squareWidth)];
        
        //创建格子初始状态
        components.day = i + 1;
        NSDate *sqDate = [gregorian dateFromComponents:components];
        NSInteger cpResult = [self dateIsFromNow:sqDate];
        if (cpResult > 0) {
            if (cpResult == 1) {
                dateSq.isToday = YES;
                [dateSq setSelectedWith:@"今天" andColor:[UIColor brownColor]];
            }
            dateSq.squareType = SQUARE_TYPE_NORMAL;
        } else {
            dateSq.squareType = SQUARE_TYPE_EXPIRED;
        }
        [dateSq addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dateSq];
        
        //设置格子当前状态
        NSString *stateName = [self checkDateIsNeedSelected:sqDate];
        if (stateName != nil) {
            dateSq.isToday = NO;//选中了就抹除当天状态
            [dateSq setSelectedWith:stateName andColor:nil];
        }
    }
    
    //填充上月格子
    NSDateComponents *previousMonthComponents = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.defaultDate];
    previousMonthComponents.month -=1;
    NSDate *previousMonthDate = [gregorian dateFromComponents:previousMonthComponents];
    NSRange previousMonthDays = [c rangeOfUnit:NSDayCalendarUnit
                                        inUnit:NSMonthCalendarUnit
                                       forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekday;

    for (int i=0; i<weekday; i++) {
        LbadDateSquare *dateSq = [LbadDateSquare buttonWithType:UIButtonTypeCustom];
        dateSq.titleLabel.text = [NSString stringWithFormat:@"%ld",maxDate+i+1];
        [dateSq setTitle:[NSString stringWithFormat:@"%ld",maxDate+i+1] forState:UIControlStateNormal];
        NSInteger offsetX = (squareWidth*(i%columns));
        NSInteger offsetY = (squareWidth *(i/columns));
        
        [dateSq setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, squareWidth, squareWidth)];
        
        //创建格子初始状态
        previousMonthComponents.day = maxDate+i+1;
        NSDate *sqDate = [gregorian dateFromComponents:previousMonthComponents];
        NSInteger cpResult = [self dateIsFromNow:sqDate];
        if (cpResult > 0) {
            if (cpResult == 1) {
                dateSq.isToday = YES;
                [dateSq setSelectedWith:@"今天" andColor:[UIColor brownColor]];
            }
            dateSq.squareType = SQUARE_TYPE_NEXTOREXPIRED;
        } else {
            dateSq.squareType = SQUARE_TYPE_EXPIRED;
        }
        [dateSq addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dateSq];
        
        //设置格子当前状态
        NSString *stateName = [self checkDateIsNeedSelected:sqDate];
        if (stateName != nil) {
            dateSq.isToday = NO;//选中了就抹除当天状态
            [dateSq setSelectedWith:stateName andColor:nil];
        }
    }
    
    //填充下月格子
    
    NSDateComponents *nextMonthComponents = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.defaultDate];
    nextMonthComponents.month +=1;
    
    NSInteger remainingDays = (monthLength + weekday) % columns;
    if(remainingDays > 0){
        for (int i=remainingDays; i<columns; i++) {
            LbadDateSquare *dateSq = [LbadDateSquare buttonWithType:UIButtonTypeCustom];
            dateSq.titleLabel.text = [NSString stringWithFormat:@"%ld",(i+1)-remainingDays];
            [dateSq setTitle:[NSString stringWithFormat:@"%ld",(i+1)-remainingDays] forState:UIControlStateNormal];
            NSInteger offsetX = (squareWidth*((i) %columns));
            NSInteger offsetY = (squareWidth *((monthLength+weekday)/columns));
            [dateSq setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, squareWidth, squareWidth)];
            [dateSq addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
            
            //创建格子初始状态
            nextMonthComponents.day = (i+1)-remainingDays;
            NSDate *sqDate = [gregorian dateFromComponents:nextMonthComponents];
            NSInteger cpResult = [self dateIsFromNow:sqDate];
            if (cpResult > 0) {
                if (cpResult == 1) {
                    dateSq.isToday = YES;
                    [dateSq setSelectedWith:@"今天" andColor:[UIColor brownColor]];
                }
                dateSq.squareType = SQUARE_TYPE_NEXTOREXPIRED;
            } else {
                dateSq.squareType = SQUARE_TYPE_EXPIRED;
            }
            [dateSq addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:dateSq];
            
            //设置格子当前状态
            NSString *stateName = [self checkDateIsNeedSelected:sqDate];
            if (stateName != nil) {
                dateSq.isToday = NO;//选中了就抹除当天状态
                [dateSq setSelectedWith:stateName andColor:nil];
            }
            
        }
    }
}


-(void)setCalendarParameters
{
    if(gregorian == nil)
    {
        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.defaultDate];
//        _selectedDay  = components.day;
//        _selectedMonth = components.month;
//        _selectedYear = components.year;
    }
}

#pragma mark actions

- (IBAction)tappedDate:(UIButton *)sender
{
    LbadDateSquare *btn = (LbadDateSquare *)sender;
    if (btn.isSelected == YES && btn.isToday == NO) {
        [btn setUnSelected];
    } else {
        //判断是当天，就变成当天状态
        if ([self dateIsFromNow:sqDate] == 1) {
            [btn setSelectedWith:@"今天" andColor:[UIColor brownColor]];
        } else {//其他的，就设置选中状态
            
            //过期的日期不能选中
            if (btn.squareType != SQUARE_TYPE_EXPIRED) {
                [btn setSelectedWith:@"启程" andColor:nil];
                btn.isToday = NO;
            }
        }
       
//        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        
//        _selectedDay = sender.tag;
//        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.defaultDate];
//        components.day = _selectedDay;
//        _selectedMonth = components.month;
//        _selectedYear = components.year;
//        NSDate *clickedDate = [gregorian dateFromComponents:components];
//        NSLog(@"%@",[DateUtils dateToString:@"yyyy-MM-dd" date:clickedDate]);
//        NSDate *date2 = [DateUtils stringToDate:@"yyyy-MM-dd" dateString:@"2014-06-22"];
//        NSLog(@"%@",[DateUtils dateToString:@"yyyy-MM-dd" date:date2]);
    }
    
}

- (IBAction)doneBtnClick:(id)sender
{
    
}

- (IBAction)clickRightAction:(id)sender
{
    [self showNextMonth];
}

- (IBAction)clickLeftAction:(id)sender
{
    [self showLastMonth];
}

- (void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self showNextMonth];
}

- (void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self showLastMonth];
}

- (void)showNextMonth
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.defaultDate];
    components.day = 1;
    components.month += 1;
    self.defaultDate = [gregorian dateFromComponents:components];
    [self setNeedsDisplay];
//    [UIView transitionWithView:self
//                      duration:0.5f
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^ { [self setNeedsDisplay]; }
//                    completion:nil];
}

- (void)showLastMonth
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.defaultDate];
    components.day = 1;
    components.month -= 1;
    self.defaultDate = [gregorian dateFromComponents:components];
    [self setNeedsDisplay];
//    [UIView transitionWithView:self
//                      duration:0.5f
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^ { [self setNeedsDisplay]; }
//                    completion:nil];
}

#pragma mark utils

//判断所给的日期是否再当前日期之后，0为之前，1为相等，2为之后
- (NSInteger)dateIsFromNow:(NSDate *)date
{
    NSInteger flag = 0;
    
    NSTimeInterval gapInterval = [date timeIntervalSinceDate:nowDate];
    
    if (gapInterval == 0) {
        flag = 1;
    } else if (gapInterval > 0) {
        flag = 2;
    } else if (gapInterval < 0){
        flag = 0;
    }
    
    return flag;
}

//判断当前日期是否需要选中，返回选中状态文字
- (NSString *)checkDateIsNeedSelected:(NSDate *)date
{
    NSString *returnStr;
    if (selectedDateArray != nil && selectedDateArray.count > 0) {
        BOOL hasOne = NO;
        NSInteger index = 0;
        for (NSInteger i=0; i<selectedDateArray.count; i++) {
            if ([date isEqualToDate:[selectedDateArray objectAtIndex:i]]) {
                hasOne = YES;
                index = i;
                break;
            }
        }
        if (hasOne == YES) {
            if (selectedDateArray.count == 1) {
                returnStr = @"1天";
            } else {
                if (index == 0) {
                    returnStr = @"启程";
                } else if (index == selectedDateArray.count - 1)
                {
                    returnStr = @"返程";
                } else
                {
                    returnStr = [NSString stringWithFormat:@"第%ld天",index+1];
                }
            }
        }
    }
    
    return returnStr;
}

@end
