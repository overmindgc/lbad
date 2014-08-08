//
//  TravelPlanService.m
//  lbad
//
//  Created by 辰 宫 on 14-8-8.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "TravelPlanService.h"
#import "TravelPlanVO.h"

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

@end
