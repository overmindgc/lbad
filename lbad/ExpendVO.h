//
//  ExpendVO.h
//  lbad
//  消费项VO
//  Created by 辰 宫 on 14-8-12.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpendVO : NSObject

/*消费类型id*/
@property (nonatomic,copy)NSString *typeId;
/*消费名称*/
@property (nonatomic,copy)NSString *expendName;
/*消费金额*/
@property (nonatomic,copy)NSString *expendMoney;
/*消费人数*/
@property (nonatomic,copy)NSString *travelerNum;

@end
