//
//  Consts.h
//  lbad
//
//  Created by 辰 宫 on 14-7-30.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consts : NSObject

/*系统主色*/
@property(nonatomic) UIColor *MAIN_COLOR;
/*系统字体*/
@property(nonatomic) NSString *FONT_NAME;
/*系统字体-加粗*/
@property(nonatomic) NSString *FONT_NAME_BOLD;

+ (Consts *)sharedInstance;

@end
