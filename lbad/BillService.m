//
//  BillService.m
//  lbad
//
//  Created by 辰 宫 on 14-8-26.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "BillService.h"

@implementation BillService

- (void)getSettlementListData:(settlementListCompleteBlock)completionBlock
{
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *settlementDict = [[NSMutableDictionary alloc] init];
    [settlementDict setValue:@"¥500" forKey:@"payment"];
    [settlementDict setValue:@"3000" forKey:@"collection"];
    
    NSMutableArray *paymentArray = [[NSMutableArray alloc] init];
    NSDictionary *dp1 = [NSDictionary dictionaryWithObjects:@[@"刘强",@"¥300元"] forKeys:@[@"name",@"amount"]];
    NSDictionary *dp2 = [NSDictionary dictionaryWithObjects:@[@"王宝强",@"¥1000000元"] forKeys:@[@"name",@"amount"]];
    NSDictionary *dp3 = [NSDictionary dictionaryWithObjects:@[@"欧阳自远",@"¥100元"] forKeys:@[@"name",@"amount"]];
    [paymentArray addObject:dp1];
    [paymentArray addObject:dp2];
    [paymentArray addObject:dp3];
    [settlementDict setValue:paymentArray forKey:@"payment_array"];
    
    NSMutableArray *collectionArray = [[NSMutableArray alloc] init];
    NSDictionary *dc1 = [NSDictionary dictionaryWithObjects:@[@"李强",@"¥2000元"] forKeys:@[@"name",@"amount"]];
    NSDictionary *dc2 = [NSDictionary dictionaryWithObjects:@[@"小强",@"¥1000元"] forKeys:@[@"name",@"amount"]];
    [collectionArray addObject:dc1];
    [collectionArray addObject:dc2];
    [settlementDict setValue:collectionArray forKey:@"colletion_array"];
    
    [resultDict setValue:settlementDict forKey:@"data"];
    
    completionBlock(resultDict);
}

@end
