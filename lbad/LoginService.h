//
//  LoginService.h
//  lbad
//
//  Created by 辰 宫 on 14-8-6.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "BaseNetEngine.h"

@interface LoginService : BaseNetEngine

- (void)doLoginWithUserName:(NSString *)username password:(NSString *)password;

@end
