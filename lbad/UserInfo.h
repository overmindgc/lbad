//
//  UserInfo.h
//  lbad
//  登陆后保存用户的信息，单例
//  Created by 辰 宫 on 14-8-8.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (UserInfo *)sharedInstance;

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;

@end
