//
//  LoginService.h
//  lbad
//
//  Created by 辰 宫 on 14-8-6.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "BaseNetEngine.h"

@interface LoginService : BaseNetEngine

typedef void (^loginCompleteBlock)(NSDictionary *resDict);
- (void)doLoginWithUserName:(NSString *)username password:(NSString *)password completeBlock:(loginCompleteBlock) completionBlock;

@end
