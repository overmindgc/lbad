//
//  AppDelegate.h
//  lbad
//
//  Created by 辰 宫 on 14-7-25.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginService.h"
#import "TravelPlanService.h"
#import "BillService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginService *loginService;

@property (strong, nonatomic) TravelPlanService *travelPlanService;

@property (strong, nonatomic) BillService *billService;

- (void)openLoginView;

- (void)openHomeView;

@end
