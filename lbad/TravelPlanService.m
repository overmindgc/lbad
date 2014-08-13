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
#import "TravelRouteCellVO.h"
#import "WeatherVO.h"

@implementation TravelPlanService

- (void)getRunningTravelPlanList:(runningPlanCompleteBlock)completionBlock
{
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    TravelPlanVO *tp1 = [[TravelPlanVO alloc] init];
    tp1.travel_id = @"1";
    tp1.description = @"8月青岛出差";
    TravelPlanVO *tp2 = [[TravelPlanVO alloc] init];
    tp2.travel_id = @"2";
    tp2.description = @"9月南京项目验收";
    TravelPlanVO *tp3 = [[TravelPlanVO alloc] init];
    tp3.travel_id = @"3";
    tp3.description = @"10月广州培训";
//    TravelPlanVO *tp4 = [[TravelPlanVO alloc] init];
//    tp4.travel_id = @"4";
//    tp4.description = @"11月南京出差";
    
    NSArray *tpArr = [NSArray arrayWithObjects:tp1,tp2,tp3, nil];
    
    [resultDict setValue:tpArr forKey:@"data"];
    
    completionBlock(resultDict);
}

- (void)getAllExpendListDataByTravelId:(NSString *)travelId completion:(expendListCompleteBlock)completionBlock
{
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];

    [dataArr addObject:@"¥1000"];
    [dataArr addObject:@"¥3500"];
    
    ExpendVO *ep1 = [[ExpendVO alloc] init];
    ep1.expend_name = @"火车票";
    ep1.expend_money = @"2500元";
    ep1.traveler_num = @"5人";
    ExpendVO *ep2 = [[ExpendVO alloc] init];
    ep2.expend_name = @"出租车";
    ep2.expend_money = @"80000元";
    ep2.traveler_num = @"500人";
    ExpendVO *ep3 = [[ExpendVO alloc] init];
    ep3.expend_name = @"冷饮";
    ep3.expend_money = @"30元";
    ep3.traveler_num = @"3人";
    ExpendVO *ep4 = [[ExpendVO alloc] init];
    ep4.expend_name = @"住宿费";
    ep4.expend_money = @"600元";
    ep4.traveler_num = @"5人";
    NSArray *todayArr = [NSArray arrayWithObjects:ep1,ep2,ep3,ep4, nil];
    NSDictionary *todayDict = [NSDictionary dictionaryWithObject:todayArr forKey:@"今日       个人支出¥1000   实际消费¥3500"];
    [dataArr addObject:todayDict];
    
    ExpendVO *ep5 = [[ExpendVO alloc] init];
    ep5.expend_name = @"公交大巴";
    ep5.expend_money = @"24元";
    ep5.traveler_num = @"3人";
    ExpendVO *ep6 = [[ExpendVO alloc] init];
    ep6.expend_name = @"午饭";
    ep6.expend_money = @"150元";
    ep6.traveler_num = @"5人";
    NSArray *yesterdayArr = [NSArray arrayWithObjects:ep5,ep6, nil];
    NSDictionary *yesterdayDict = [NSDictionary dictionaryWithObject:yesterdayArr forKey:@"昨日"];
    [dataArr addObject:yesterdayDict];
    
    ExpendVO *ep7 = [[ExpendVO alloc] init];
    ep7.expend_name = @"早饭";
    ep7.expend_money = @"50元";
    ep7.traveler_num = @"5人";
    NSArray *earlydayArr = [NSArray arrayWithObjects:ep7, nil];
    NSDictionary *earlydayDict = [NSDictionary dictionaryWithObject:earlydayArr forKey:@"8-2"];
    [dataArr addObject:earlydayDict];
                                
    
    [resultDict setValue:dataArr forKeyPath:@"data"];
    completionBlock(resultDict);
}

- (void)getAllTravelRouteDataByTravelId:(NSString *)travelId completion:(travelRouteCompleteBlock)completionBlock
{
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    [resultDict setValue:@"14天" forKey:@"day_num"];
    [resultDict setValue:@"8月2日至8月16日" forKey:@"date_range"];
    
    TravelRouteCellVO *tr1 = [[TravelRouteCellVO alloc] init];
    tr1.route_date_type = @"8月2日 火车 G119";
    tr1.route_time_dest = @"10:00北京南站 - 南京南站16:00";
    TravelRouteCellVO *tr2 = [[TravelRouteCellVO alloc] init];
    tr2.route_date_type = @"8月5日 火车";
    tr2.route_time_dest = @"18:00南京南站 - 上海站20:00";
    TravelRouteCellVO *tr3 = [[TravelRouteCellVO alloc] init];
    tr3.route_date_type = @"8月10日 飞机 MH17";
    tr3.route_time_dest = @"7:30上海国际机场 - 北京国际机场11:00";
    NSArray *routeArr = [NSArray arrayWithObjects:tr1,tr2,tr3, nil];
    [resultDict setValue:routeArr forKey:@"route_array"];
    
    WeatherVO *w1 = [[WeatherVO alloc] init];
    w1.place_name = @"南京";
    w1.weather_type = @"sunny";
    w1.description = @"22-30度  西南风2-3级";
    WeatherVO *w2 = [[WeatherVO alloc] init];
    w2.place_name = @"上海";
    w2.weather_type = @"cloudsun";
    w2.description = @"23-30度  微风";
    WeatherVO *w3 = [[WeatherVO alloc] init];
    w3.place_name = @"北京";
    w3.weather_type = @"torrentrain";
    w3.description = @"18-24度  东北风6-7级";
    WeatherVO *w4 = [[WeatherVO alloc] init];
    w4.place_name = @"乌鲁木齐";
    w4.weather_type = @"rain";
    w4.description = @"18-24度  东北风6-7级";
    WeatherVO *w5 = [[WeatherVO alloc] init];
    w5.place_name = @"张家口";
    w5.weather_type = @"cloudsun";
    w5.description = @"18-24度  东北风6-7级";
    NSArray *weatherArr = [NSArray arrayWithObjects:w1,w2,w3, nil];
    [resultDict setValue:weatherArr forKey:@"weather_array"];
    
    [resultDict setValue:resultDict forKeyPath:@"data"];
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
