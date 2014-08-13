//
//  WeatherVO.h
//  lbad
//  天气数据VO
//  Created by 辰 宫 on 14-8-13.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherVO : NSObject

/*地点*/
@property (nonatomic, copy)NSString *place_name;
/*天气类型*/
@property (nonatomic, copy)NSString *weather_type;
/*温度风力等描述*/
@property (nonatomic, copy)NSString *description;

@end
