//
//  BillService.h
//  lbad
//
//  Created by 辰 宫 on 14-8-26.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "BaseNetEngine.h"

@interface BillService : BaseNetEngine

/*获取结算单统计数据*/
typedef void (^settlementListCompleteBlock)(NSDictionary *resDict);
- (void)getSettlementListData:(settlementListCompleteBlock)completionBlock;

/*获取核算单列表数据*/
typedef void (^getAccountListCompleteBlock)(NSDictionary *resDict);
- (void)getAccountListDataById:(NSString *)settlementId completion:(getAccountListCompleteBlock)completionBlock;

@end
