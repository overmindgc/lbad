//
//  TravelPlanVO.h
//  lbad
//  旅程计划对象
//  Created by 辰 宫 on 14-8-8.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelPlanVO : NSObject

/*旅程id*/
@property (nonatomic,copy) NSString *travelId;
/*旅程描述（标题）*/
@property (nonatomic,copy) NSString *description;

@end
