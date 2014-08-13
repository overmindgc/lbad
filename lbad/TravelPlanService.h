//
//  TravelPlanService.h
//  lbad
//
//  Created by 辰 宫 on 14-8-8.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "BaseNetEngine.h"

@interface TravelPlanService : BaseNetEngine

/*获取正在进行的旅程列表*/
typedef void (^runningPlanCompleteBlock)(NSDictionary *resDict);
- (void)getRunningTravelPlanList:(runningPlanCompleteBlock)completionBlock;

/*获取旅程的所有消费清单数据*/
typedef void (^expendListCompleteBlock)(NSDictionary *resDict);
- (void)getAllExpendListDataByTravelId:(NSString *)travelId completion:(expendListCompleteBlock)completionBlock;

/*获取旅程行程所有数据*/
typedef void (^travelRouteCompleteBlock)(NSDictionary *resDict);
- (void)getAllTravelRouteDataByTravelId:(NSString *)travelId completion:(travelRouteCompleteBlock)completionBlock;

/*查询同程旅伴列表*/
typedef void (^sameRouteTravelerCompleteBlock)(NSDictionary *resDict);
- (void)getSameRouteTravelerListByTravelId:(NSString *)travelId completion:(sameRouteTravelerCompleteBlock)completionBlock;

@end
