//
//  AppDelegate.m
//  lbad
//
//  Created by 辰 宫 on 14-7-25.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginNavigationController.h"
#import "HomeNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //设置弹出提示组件样式
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.15 alpha:0.8]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    /**初始代理类*/
    //登陆服务
    self.loginService = [[LoginService alloc] initWithHostName:APP_NETWORK_HOST];
    [self.loginService useCache];
    //旅程计划服务
    self.travelPlanService = [[TravelPlanService alloc] initWithHostName:APP_NETWORK_HOST];
    [self.travelPlanService useCache];
    //账单服务
    self.billService = [[BillService alloc] initWithHostName:APP_NETWORK_HOST];
    [self.billService useCache];
    
    [self openLoginView];
    
    return YES;
}

#pragma mark custom functions

- (void)openLoginView
{
    self.window.rootViewController = nil;
    LoginNavigationController *loginNav = [[LoginNavigationController alloc] init];
    self.window.rootViewController = loginNav;
}

- (void)openHomeView
{
    self.window.rootViewController = nil;
    HomeNavigationController *homeNav = [[HomeNavigationController alloc] init];
    self.window.rootViewController = homeNav;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
