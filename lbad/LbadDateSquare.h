//
//  LbadDateSquare.h
//  lbad
//  日期格子
//  Created by 辰 宫 on 14-7-29.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

//格子类型
enum {
    SQUARE_TYPE_NORMAL = 0,//正常
    SQUARE_TYPE_EXPIRED = 1,//过期
    SQUARE_TYPE_NEXTOREXPIRED = 3//下月或当月过期
};

@interface LbadDateSquare : UIButton

//格子类型
@property int squareType;
//是否是今天
@property BOOL isToday;
//当前格子的日期
@property NSDate *currDate;

//描述标签
@property UILabel *descLabel;

//设置选中状态
- (void)setSelectedWith:(NSString *)descText andColor:(UIColor *)bgColor;
//取消选中
- (void)setUnSelected;
@end
