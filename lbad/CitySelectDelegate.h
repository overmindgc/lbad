//
//  CitySelectDelegate.h
//  lbad
//
//  Created by 辰 宫 on 14-8-21.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CitySelectDelegate <NSObject>

@required
- (void)selectCity:(NSString *)cityName;

@end
