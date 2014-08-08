//
//  BaseNetProxy.m
//  lbad
//
//  Created by 辰 宫 on 14-8-6.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "BaseNetEngine.h"

@implementation BaseNetEngine

- (MKNetworkOperation *)startRequestWithPath:(NSString *)path param:(NSMutableDictionary *)dict completeBlock:(completeBlock)completeBlock errorBlock:(errorBlock)errorBlock type:(NSString *)type
{
    if (type == nil) {
        type = @"POST";
    }
    MKNetworkOperation *op = [self operationWithPath:path params:dict httpMethod:type];
//    [op setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
//        NSLog(@"responseData : %@", [operation responseString]);
        NSData *data = [operation responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@",resDict);
        completeBlock(resDict);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *err) {
        //如果有自定义的error处理，则调用，否则调用默认处理
        if (errorBlock == nil) {
            NSLog(@"MKNetWork请求错误 ：%@",[err localizedDescription]);
        } else
        {
            errorBlock([err localizedDescription]);
        }
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

@end
