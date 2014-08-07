//
//  BaseNetProxy.m
//  lbad
//
//  Created by 辰 宫 on 14-8-6.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "BaseNetEngine.h"

@implementation BaseNetEngine

- (MKNetworkOperation *)startRequestWithPath:(NSString *)path param:(NSMutableDictionary *)dict completeBlock:(completeBlock)completeBlock type:(NSString *)type
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
    } errorHandler:errorBlock];
    
    [self enqueueOperation:op];
    
    return op;
}

/*通信错误block*/
void (^errorBlock)(MKNetworkOperation *errorOp, NSError *err) = ^(MKNetworkOperation *errorOp, NSError *err) {
    NSLog(@"MKNetWork请求错误 ：%@",[err localizedDescription]);
};

@end
