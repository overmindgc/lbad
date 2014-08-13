//
//  TravelRouteCellVO.h
//  lbad
//  行程单元数据VO
//  Created by 辰 宫 on 14-8-13.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelRouteCellVO : NSObject

/*行程id*/
@property (nonatomic, copy)NSString *route_id;
/*行程日期和类型描述*/
@property (nonatomic, copy)NSString *route_date_type;
/*行程时间和地点*/
@property (nonatomic, copy)NSString *route_time_dest;


@end
