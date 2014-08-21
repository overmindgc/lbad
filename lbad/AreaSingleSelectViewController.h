//
//  AreaSingleSelectViewController.h
//  lbad
//
//  Created by 辰 宫 on 14-8-19.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitySelectDelegate.h"

@interface AreaSingleSelectViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, weak) id <CitySelectDelegate> selectDelegate;

@end
