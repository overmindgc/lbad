//
//  AppConsts.h
//  lbad
//  存放系统常量的类(能使用常量的尽量使用常量不要使用宏定义)
//  Created by 辰 宫 on 14-8-19.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConsts : NSObject

/*后台根目录*/
FOUNDATION_EXPORT NSString *const APP_NETWORK_HOST;

/*下拉刷新提示文字*/
FOUNDATION_EXPORT NSString *const PULL_TIP_TEXT;

/*下拉刷新加载数据文字*/
FOUNDATION_EXPORT NSString *const PULL_LOAD_DATA_TEXT;

@end
