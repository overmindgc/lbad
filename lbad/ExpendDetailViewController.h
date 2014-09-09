//
//  ExpendDetailViewController.h
//  lbad
//
//  Created by 辰 宫 on 14-8-29.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpendDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *titleName;

@property (weak, nonatomic) IBOutlet UINavigationItem *topTitleItem;
@property (weak, nonatomic) IBOutlet UIView *topBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *expendMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *payInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultMoneyLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
