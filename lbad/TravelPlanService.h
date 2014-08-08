//
//  TravelPlanService.h
//  lbad
//
//  Created by 辰 宫 on 14-8-8.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "BaseNetEngine.h"

@interface TravelPlanService : BaseNetEngine

typedef void (^runningPlanCompleteBlock)(NSDictionary *resDict);
- (void)getRunningTravelPlanList:(runningPlanCompleteBlock)completionBlock;

@end
