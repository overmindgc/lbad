//
//  LoginService.m
//  lbad
//
//  Created by 辰 宫 on 14-8-6.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "LoginService.h"

#define LOGIN_URL @"/user/login"

@implementation LoginService

- (void)doLoginWithUserName:(NSString *)username password:(NSString *)password
{
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setValue:@"username" forKey:username];
    [paramDict setValue:@"password" forKey:password];
    [self startRequestWithPath:LOGIN_URL param:paramDict type:@"GET"];
}

@end
