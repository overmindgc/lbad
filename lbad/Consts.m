//
//  Consts.m
//  lbad
//
//  Created by 辰 宫 on 14-7-30.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "Consts.h"

@implementation Consts

- (UIColor *)MAIN_COLOR
{
    return [UIColor colorWithRed:66.0f/255.0f green:133.0f/255.0f blue:60.0f/255.0f alpha:1];
}

- (NSString *)FONT_NAME
{
    return @"HelveticaNeue";
}

- (NSString *)FONT_NAME_BOLD
{
    return @"HelveticaNeue-Bold";
}



+ (Consts *)sharedInstance
{
    static dispatch_once_t once;
    static Consts *sharedInstance = nil;
    
    dispatch_once(&once, ^
                  {
                      sharedInstance = [[self alloc] init];
                  });
    
    return sharedInstance;
}

@end
