//
//  JourneyTravelRouteView.h
//  lbad
//
//  Created by 辰 宫 on 14-8-11.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JourneyTravelRouteView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewRoute;

@property (nonatomic, strong) UIRefreshControl *refControl;

@end
