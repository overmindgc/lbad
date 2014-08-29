//
//  AccountListViewController.h
//  lbad
//
//  Created by 辰 宫 on 14-8-27.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *settlementId;

@property (nonatomic, strong) NSString *payOrCollectionName;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@property (weak, nonatomic) IBOutlet UIButton *payButton;

@property (nonatomic, strong) UIRefreshControl *refControl;

@end
