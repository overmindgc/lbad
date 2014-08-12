//
//  JourneyMainViewController.h
//  lbad
//
//  Created by 辰 宫 on 14-8-11.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelPlanVO.h"

@interface JourneyMainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *topNavBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *topTitleItem;
@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (weak, nonatomic) IBOutlet UILabel *expendListLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelersLabel;

/*存储当前旅程的model对象*/
@property (nonatomic, strong) TravelPlanVO *currTPVO;

@end
