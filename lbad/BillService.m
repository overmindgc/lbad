//
//  BillService.m
//  lbad
//
//  Created by 辰 宫 on 14-8-26.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "BillService.h"
#import "ExpendVO.h"

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

- (void)getAccountListDataById:(NSString *)settlementId completion:(getAccountListCompleteBlock)completionBlock
{
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *resDict = [[NSMutableDictionary alloc] init];
    
    [resDict setValue:@"刘强" forKey:@"payfor_name"];
    [resDict setValue:@"¥500" forKey:@"payfor_amount"];
    
    [resDict setValue:@"500元" forKey:@"my_pay_amount"];
    [resDict setValue:@"1000元" forKey:@"he_pay_amount"];
    
    NSMutableArray *myPayArr = [[NSMutableArray alloc] init];
    ExpendVO *ep1 = [[ExpendVO alloc] init];
    ep1.expend_name = @"火车票";
    ep1.expend_money = @"2500元";
    ep1.traveler_num = @"5人";
    ExpendVO *ep2 = [[ExpendVO alloc] init];
    ep2.expend_name = @"出租车";
    ep2.expend_money = @"80000元";
    ep2.traveler_num = @"500人";
    NSArray *todayArr = [NSArray arrayWithObjects:@"今日",ep1,ep2, nil];
    [myPayArr addObject:todayArr];
    [resDict setValue:myPayArr forKey:@"my_pay_list"];
    
    NSMutableArray *hePayArr = [[NSMutableArray alloc] init];
    ExpendVO *ep3 = [[ExpendVO alloc] init];
    ep3.expend_name = @"冷饮";
    ep3.expend_money = @"30元";
    ep3.traveler_num = @"3人";
    ExpendVO *ep4 = [[ExpendVO alloc] init];
    ep4.expend_name = @"住宿费";
    ep4.expend_money = @"600元";
    ep4.traveler_num = @"5人";
    NSArray *heTodayArr = [NSArray arrayWithObjects:@"今日",ep3,ep4, nil];
    [hePayArr addObject:heTodayArr];
    ExpendVO *ep5 = [[ExpendVO alloc] init];
    ep5.expend_name = @"公交大巴";
    ep5.expend_money = @"24元";
    ep5.traveler_num = @"3人";
    ExpendVO *ep6 = [[ExpendVO alloc] init];
    ep6.expend_name = @"午饭";
    ep6.expend_money = @"150元";
    ep6.traveler_num = @"5人";
    NSArray *heYesterdayArr = [NSArray arrayWithObjects:@"昨日",ep5,ep6, nil];
    [hePayArr addObject:heYesterdayArr];
    ExpendVO *ep7 = [[ExpendVO alloc] init];
    ep7.expend_name = @"早饭";
    ep7.expend_money = @"50元";
    ep7.traveler_num = @"5人";
    NSArray *heEarlyArr = [NSArray arrayWithObjects:@"8-24",ep7, nil];
    [hePayArr addObject:heEarlyArr];
    [resDict setValue:hePayArr forKey:@"he_pay_list"];
    
    [resultDict setValue:resDict forKeyPath:@"data"];
    completionBlock(resultDict);
}

@end
