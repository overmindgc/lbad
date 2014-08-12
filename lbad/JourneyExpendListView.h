//
//  JourneyExpendListView.h
//  lbad
//
//  Created by 辰 宫 on 14-8-11.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JourneyExpendListView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *personalExpendLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalExpendLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableViewExpend;

@end
