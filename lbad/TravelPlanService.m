//
//  TravelPlanService.m
//  lbad
//
//  Created by 辰 宫 on 14-8-8.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "TravelPlanService.h"
#import "TravelPlanVO.h"
#import "TravelerVO.h"
#import "ExpendVO.h"

@implementation TravelPlanService

- (void)getRunningTravelPlanList:(runningPlanCompleteBlock)completionBlock
{
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    TravelPlanVO *tp1 = [[TravelPlanVO alloc] init];
    tp1.travelId = @"1";
    tp1.description = @"8月青岛出差";
    TravelPlanVO *tp2 = [[TravelPlanVO alloc] init];
    tp2.travelId = @"2";
    tp2.description = @"9月南京项目验收";
    TravelPlanVO *tp3 = [[TravelPlanVO alloc] init];
    tp3.travelId = @"3";
    tp3.description = @"10月广州培训";
//    TravelPlanVO *tp4 = [[TravelPlanVO alloc] init];
//    tp4.travelId = @"4";
//    tp4.description = @"11月南京出差";
    
    NSArray *tpArr = [NSArray arrayWithObjects:tp1,tp2,tp3, nil];
    
    [resultDict setValue:tpArr forKey:@"data"];
    
    completionBlock(resultDict);
}

- (void)getAllExpendListDataByTravelId:(NSString *)travelId completion:(expendListCompleteBlock)completionBlock
{
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setValue:@"¥1000" forKey:@"personalMonay"];
    [dataDict setValue:@"¥3500" forKey:@"totalMonay"];
    
    ExpendVO *ep1 = [[ExpendVO alloc] init];
    ep1.expendName = @"火车";
    ep1.expendMoney = @"2500元";
    ep1.travelerNum = @"5人";
    ExpendVO *ep2 = [[ExpendVO alloc] init];
    ep2.expendName = @"出租车";
    ep2.expendMoney = @"80元";
    ep2.travelerNum = @"5人";
    ExpendVO *ep3 = [[ExpendVO alloc] init];
    ep3.expendName = @"冷饮";
    ep3.expendMoney = @"30元";
    ep3.travelerNum = @"3人";
    ExpendVO *ep4 = [[ExpendVO alloc] init];
    ep4.expendName = @"住宿费";
    ep4.expendMoney = @"600元";
    ep4.travelerNum = @"5人";
    NSArray *todayArr = [NSArray arrayWithObjects:ep1,ep2,ep3,ep4, nil];
    [dataDict setValue:todayArr forKey:@"今日      个人支出¥1000   实际消费¥3500"];
    
    ExpendVO *ep5 = [[ExpendVO alloc] init];
    ep5.expendName = @"地铁";
    ep5.expendMoney = @"24元";
    ep5.travelerNum = @"3人";
    ExpendVO *ep6 = [[ExpendVO alloc] init];
    ep6.expendName = @"午饭";
    ep6.expendMoney = @"150元";
    ep6.travelerNum = @"5人";
    NSArray *yesterdayArr = [NSArray arrayWithObjects:ep5,ep6, nil];
    [dataDict setValue:yesterdayArr forKey:@"昨日"];
    
    ExpendVO *ep7 = [[ExpendVO alloc] init];
    ep7.expendName = @"早饭";
    ep7.expendMoney = @"50元";
    ep7.travelerNum = @"5人";
    NSArray *earlydayArr = [NSArray arrayWithObjects:ep7, nil];
    [dataDict setValue:earlydayArr forKey:@"8-2"];
    
    NSDictionary *newDataDict = [NSDictionary dictionaryWithObjects:@[@"¥1000",@"¥3500",todayArr,yesterdayArr,earlydayArr] forKeys:@[@"personalMonay",@"totalMonay",@"今日      个人支出¥1000   实际消费¥3500",@"昨日",@"8-2"]];
    
    [resultDict setValue:newDataDict forKeyPath:@"data"];
    completionBlock(resultDict);
}

- (void)getSameRouteTravelerListByTravelId:(NSString *)travelId completion:(sameRouteTravelerCompleteBlock)completionBlock
{
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    TravelerVO *t1 = [[TravelerVO alloc] init];
    t1.user_id = @"1";
    t1.user_name = @"刘强";
    t1.user_portrait_url = @"liuqiang.png";
    TravelerVO *t2 = [[TravelerVO alloc] init];
    t2.user_id = @"2";
    t2.user_name = @"李强";
    t2.user_portrait_url = @"liuqiang.png";
    TravelerVO *t3 = [[TravelerVO alloc] init];
    t3.user_id = @"3";
    t3.user_name = @"王宝强";
    t3.user_portrait_url = @"wangbaoqiang.jpeg";
    TravelerVO *t4 = [[TravelerVO alloc] init];
    t4.user_id = @"4";
    t4.user_name = @"史强";
    t4.user_portrait_url = @"u12.png";
    TravelerVO *t5 = [[TravelerVO alloc] init];
    t5.user_id = @"5";
    t5.user_name = @"小强";
    t5.user_portrait_url = @"u12.png";
    
    NSArray *tArr = [NSArray arrayWithObjects:t1,t2,t3,t4,t5, nil];
    [resultDict setValue:tArr forKeyPath:@"data"];
    completionBlock(resultDict);
}

@end
