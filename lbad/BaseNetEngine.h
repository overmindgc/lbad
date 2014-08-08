//
//  BaseNetProxy.h
//  lbad
//
//  Created by 辰 宫 on 14-8-6.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"

@interface BaseNetEngine : MKNetworkEngine

typedef void (^completeBlock)(NSDictionary *resDict);
typedef void (^errorBlock)(NSString *errDesc);
- (MKNetworkOperation *)startRequestWithPath:(NSString *)path param:(NSMutableDictionary *)dict completeBlock:(completeBlock)completeBlock errorBlock:(errorBlock)errorBlock type:(NSString *)type;

@end
