//
//  SettlementListViewController.h
//  lbad
//  结算单页面
//  Created by 辰 宫 on 14-8-26.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettlementListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@property (nonatomic, strong) UIRefreshControl *refControl;

@end
