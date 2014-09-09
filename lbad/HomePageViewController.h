//
//  HomePageViewController.h
//  lbad
//
//  Created by 辰 宫 on 14-7-25.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *homeBackgroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewPlan;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;

@property (nonatomic, strong) UIRefreshControl *refControl;

@end
