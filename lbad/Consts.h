//
//  Consts.h
//  lbad
//
//  Created by 辰 宫 on 14-7-30.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consts : NSObject

//系统主色
@property(nonatomic) UIColor *mainColor;
//系统字体
@property(nonatomic) NSString *fontName;

+ (Consts *)sharedInstance;

@end
