//
//  TravelerVO.h
//  lbad
//  旅行人员VO
//  Created by 辰 宫 on 14-8-12.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelerVO : NSObject

/*用户id*/
@property (nonatomic,copy)NSString *user_id;
/*用户名字*/
@property (nonatomic,copy)NSString *user_name;
/*用户头像路径*/
@property (nonatomic,copy)NSString *user_portrait_url;
/*标记选中状态*/
@property BOOL selected;

@end
