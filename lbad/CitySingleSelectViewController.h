//
//  CitySingleSelectViewController.h
//  lbad
//
//  Created by 辰 宫 on 14-8-21.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitySelectDelegate.h"

@interface CitySingleSelectViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (nonatomic, copy) NSString *titleText;

@property (nonatomic, strong) NSDictionary *citySourceDict;

@property (nonatomic, weak) id <CitySelectDelegate> selectDelegate;

@end
