//
//  LbadDateSelectorViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-7-29.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "LbadDateSelectorViewController.h"
#import "CalendarView.h"
#import "LbadCalendarView.h"

@interface LbadDateSelectorViewController ()

@end

@implementation LbadDateSelectorViewController

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
    LbadCalendarView *calendar = [[LbadCalendarView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 300, self.view.bounds.size.width, 300)];
    [calendar setBackgroundColor:[UIColor whiteColor]];
    self.view = calendar;
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

-(void)tappedOnDate:(NSDate *)selectedDate
{
    NSLog(@"tappedOnDate %@(GMT)",selectedDate);
}

@end
