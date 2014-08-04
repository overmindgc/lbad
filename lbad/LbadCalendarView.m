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
    //保存当前月的格子对象
    NSMutableArray *currMonthSqArray;
}

@synthesize selectedDateArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //保存初始的日期（转化为0点）
        nowDate = [DateUtils stringToDate:@"yyyy-MM-dd" dateString:[DateUtils dateToString:@"yyyy-MM-dd" date:[NSDate date]]];
        
        self.defaultDate = nowDate;
        
        selectedDateArray = [[NSMutableArray alloc] init];
        
//        selectedDateArray = [[NSMutableArray alloc] initWithObjects:[DateUtils stringToDate:@"yyyy-MM-dd" dateString:@"2014-07-30"],
//                             [DateUtils stringToDate:@"yyyy-MM-dd" dateString:@"2014-07-31"],
//                             [DateUtils stringToDate:@"yyyy-MM-dd" dateString:@"2014-08-01"],nil];
        
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
    currMonthSqArray = [[NSMutableArray alloc] init];
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
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 120/2,8, 120
                                                                  , 30)];
    titleText.textAlignment = NSTextAlignmentCenter;
    NSString *dateString = [DateUtils dateToString:@"yyyy 年 MM 月" date:self.defaultDate];
    [titleText setText:dateString];
    [titleText setFont:[UIFont fontWithName:[Consts sharedInstance].FONT_NAME_BOLD size:18.0f]];
    [titleText setTextColor:[UIColor brownColor]];
    [self addSubview:titleText];
    
    //翻页按钮
    UIImage *leftImg = [UIImage imageNamed:@"left.png"];
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleText.frame.origin.x - 28, 11, 25, 25)];
    [leftBtn setImage:leftImg forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    
    UIImage *rightImg = [UIImage imageNamed:@"right.png"];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleText.frame.origin.x + titleText.frame.size.width, 11, 25, 25)];
    [rightBtn setImage:rightImg forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    
    //创建确定按钮
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 62, 8, 50, 30)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[Consts sharedInstance].MAIN_COLOR forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
    [doneBtn.titleLabel setFont:[UIFont fontWithName:[Consts sharedInstance].FONT_NAME_BOLD size:20.0f]];
    [doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneBtn];
    
    //创建回到今日按钮
    UIButton *todayBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 8, 50, 30)];
    [todayBtn setTitle:@"今日" forState:UIControlStateNormal];
    [todayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [todayBtn setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
    [todayBtn.titleLabel setFont:[UIFont fontWithName:[Consts sharedInstance].FONT_NAME_BOLD size:18.0f]];
    [todayBtn addTarget:self action:@selector(todayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:todayBtn];
    
    //创建星期文字
    for (int i =0; i<_weekNames.count; i++) {
        UIButton *weekNameLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        weekNameLabel.titleLabel.text = [_weekNames objectAtIndex:i];
        [weekNameLabel setTitle:[_weekNames objectAtIndex:i] forState:UIControlStateNormal];
        [weekNameLabel setFrame:CGRectMake(originX+(squareWidth*(i%columns)), originY + 10, squareWidth, squareWidth - 10)];
        [weekNameLabel setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [weekNameLabel.titleLabel setFont:[UIFont fontWithName:[Consts sharedInstance].FONT_NAME_BOLD size:14.0f]];
        weekNameLabel.userInteractionEnabled = NO;
        [self addSubview:weekNameLabel];
    }

    
    //创建当月格子
    for (NSInteger i= 0; i<monthLength; i++)
    {
        LbadDateSquare *dateSq = [LbadDateSquare buttonWithType:UIButtonTypeCustom];
        dateSq.tag = ((i+weekday)%columns+1) + ((i+weekday)/columns)*columns;
        dateSq.titleLabel.text = [NSString stringWithFormat:@"%ld",i+1];
        [dateSq setTitle:[NSString stringWithFormat:@"%ld",i+1] forState:UIControlStateNormal];
        NSInteger offsetX = (squareWidth*((i+weekday)%columns));
        NSInteger offsetY = (squareWidth *((i+weekday)/columns));
        [dateSq setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, squareWidth, squareWidth)];
        
        //创建格子初始状态
        components.day = i + 1;
        NSDate *sqDate = [gregorian dateFromComponents:components];
        dateSq.currDate = sqDate;
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
        [currMonthSqArray addObject:dateSq];
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
        dateSq.tag = i%columns + 1;
        dateSq.titleLabel.text = [NSString stringWithFormat:@"%ld",maxDate+i+1];
        [dateSq setTitle:[NSString stringWithFormat:@"%ld",maxDate+i+1] forState:UIControlStateNormal];
        NSInteger offsetX = (squareWidth*(i%columns));
        NSInteger offsetY = (squareWidth *(i/columns));
        
        [dateSq setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, squareWidth, squareWidth)];
        
        //创建格子初始状态
        previousMonthComponents.day = maxDate+i+1;
        NSDate *sqDate = [gregorian dateFromComponents:previousMonthComponents];
        dateSq.currDate = sqDate;
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
        [currMonthSqArray addObject:dateSq];
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
            dateSq.tag = i%columns + ((monthLength+weekday)/columns)*columns + 1;
            dateSq.titleLabel.text = [NSString stringWithFormat:@"%ld",(i+1)-remainingDays];
            [dateSq setTitle:[NSString stringWithFormat:@"%ld",(i+1)-remainingDays] forState:UIControlStateNormal];
            NSInteger offsetX = (squareWidth*((i) %columns));
            NSInteger offsetY = (squareWidth *((monthLength+weekday)/columns));
            [dateSq setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, squareWidth, squareWidth)];
            [dateSq addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
            
            //创建格子初始状态
            nextMonthComponents.day = (i+1)-remainingDays;
            NSDate *sqDate = [gregorian dateFromComponents:nextMonthComponents];
            dateSq.currDate = sqDate;
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
            [currMonthSqArray addObject:dateSq];
            //设置格子当前状态
            NSString *stateName = [self checkDateIsNeedSelected:sqDate];
            if (stateName != nil) {
                dateSq.isToday = NO;//选中了就抹除当天状态
                [dateSq setSelectedWith:stateName andColor:nil];
            }
            
        }
    }
    
    //5行时
    if (currMonthSqArray.count == 35) {
        [self.delegate setCalendarLow];
    } else if (currMonthSqArray.count == 42)//6行时
    {
        [self.delegate setCalendarHigh];
    }
}


-(void)setCalendarParameters
{
    if(gregorian == nil)
    {
        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
    }
}

#pragma mark actions

- (IBAction)tappedDate:(UIButton *)sender
{
    LbadDateSquare *btn = (LbadDateSquare *)sender;
//    if (btn.isSelected == YES && btn.isToday == NO) {
//        [btn setUnSelected];
//        for (NSDate *sd in selectedDateArray) {
//            if ([sd isEqualToDate:btn.currDate]) {
//                [selectedDateArray removeObject:sd];
//                break;
//            }
//        }
//    } else {
        //过期的日期不能选中
        if (btn.squareType != SQUARE_TYPE_EXPIRED) {
            btn.isToday = NO;
            [self setSqSelectedWithSq:btn];
        }
//    }
    
}

- (IBAction)doneBtnClick:(id)sender
{
    if (selectedDateArray.count > 0) {
        [self.delegate selectedOn:[selectedDateArray objectAtIndex:0]
                               to:[selectedDateArray objectAtIndex:selectedDateArray.count-1]
                        withSize:selectedDateArray.count];
    } else
    {
        [self.delegate selectedOn:nil to:nil withSize:0];
    }
}

- (IBAction)todayBtnClick:(id)sender
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:nowDate];
    self.defaultDate = [gregorian dateFromComponents:components];
    [self setNeedsDisplay];
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
//                      duration:0.3f
//                       options:UIViewAnimationOptionTransitionFlipFromBottom
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
//                      duration:0.3f
//                       options:UIViewAnimationOptionTransitionFlipFromTop
//                    animations:^ { [self setNeedsDisplay]; }
//                    completion:nil];
}

#pragma mark util functions

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
                returnStr = @"启程";
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

//根据选中的日期格子计算其他格子选中状态
- (void)setSqSelectedWithSq:(LbadDateSquare *)sq
{
    if (selectedDateArray.count == 0) {
        [selectedDateArray addObject:sq.currDate];
        [sq setSelectedWith:@"启程" andColor:nil];
    } else if (selectedDateArray.count > 0) {
        NSDate *firstDate = [selectedDateArray objectAtIndex:0];
        NSTimeInterval gapInterval = [sq.currDate timeIntervalSinceDate:firstDate];
        //如果当前只有一个已选择，并且选中了这个格子，就取消掉
        if (selectedDateArray.count == 1 && gapInterval == 0) {
            [selectedDateArray removeAllObjects];
            [self reloadSelectedState];
        } else {
            //判断是在已选日期内或者之前，是就重新作为起点
            BOOL hasReBegin = NO;
            
            //判断是否在之前或第一个
            if (gapInterval <= 0) {
                hasReBegin = YES;
            }
            if (hasReBegin == NO) {
                //继续是否在之内
                for (NSDate *sd in selectedDateArray) {
                    if ([sd isEqualToDate:sq.currDate]) {
                        hasReBegin = YES;
                        break;
                    }
                }
            }
            
            //如果在之后，就继续选中中间的
            if (hasReBegin == NO) {
                [self setSelectedDateArrayWithBegin:firstDate to:sq.currDate];
                [self reloadSelectedState];
            } else {
                [selectedDateArray removeAllObjects];
                [selectedDateArray addObject:sq.currDate];
                [self reloadSelectedState];
            }
        }
        
    }
}

//生成开始到结束日期之间所有日期，赋给selectedDateArray
- (void)setSelectedDateArrayWithBegin:(NSDate *)beginDate to:(NSDate *)endDate
{
    [selectedDateArray removeAllObjects];
    [selectedDateArray addObject:beginDate];
    NSTimeInterval oneDayInterval = 86400;
    NSDate *nextDate = [beginDate dateByAddingTimeInterval:oneDayInterval];
    while ([nextDate timeIntervalSinceDate:endDate] <= 0) {
        [selectedDateArray addObject:nextDate];
        nextDate = [nextDate dateByAddingTimeInterval:oneDayInterval];
    }
}

//重绘选中状态
- (void)reloadSelectedState
{
    for (LbadDateSquare *sq in currMonthSqArray) {
        NSString *stateName = [self checkDateIsNeedSelected:sq.currDate];
        if (stateName != nil) {
            sq.isToday = NO;//选中了就抹除当天状态
            [sq setSelectedWith:stateName andColor:nil];
        } else {
            if (sq.isToday == NO) {
                [sq setUnSelected];
            }
        }
    }
}

@end
