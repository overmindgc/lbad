//
//  HomePageViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-7-25.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "CreateJourneyViewController.h"
#import "ButtonWithNumTipView.h"
#import "AppMacro.h"

@interface HomePageViewController ()
{
    ButtonWithNumTipView *payListBtn;
    ButtonWithNumTipView *myLbBtn;
    ButtonWithNumTipView *messageBtn;
}

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.homeBackgroundView setBackgroundColor:APP_MAIN_COLOR];
    //创建三个图标
    NSInteger imgSize = 55;//图标大小
    float imgGap = ([UIScreen mainScreen].bounds.size.width - imgSize*3) / 4;
    payListBtn = [[ButtonWithNumTipView alloc] initWithFrame:CGRectMake(imgGap, 115, imgSize, imgSize)];
    payListBtn.btnText = @"账单";
    payListBtn.imgPath = @"clipboard.png";
    [self.view addSubview:payListBtn];
    
    myLbBtn = [[ButtonWithNumTipView alloc] initWithFrame:CGRectMake(imgGap*2+imgSize, 115, imgSize, imgSize)];
    myLbBtn.btnText = @"我的旅伴";
    myLbBtn.imgPath = @"speedometer.png";
    [self.view addSubview:myLbBtn];
    
    messageBtn = [[ButtonWithNumTipView alloc] initWithFrame:CGRectMake(imgGap*3+imgSize*2, 115, imgSize, imgSize)];
    messageBtn.btnText = @"消息";
    messageBtn.imgPath = @"chat.png";
    [self.view addSubview:messageBtn];
}

- (void)viewDidAppear:(BOOL)animated
{
    [payListBtn showTipNumber:@"6"];
    [myLbBtn showTipNumber:@"53"];
    [messageBtn showTipNumber:@"1"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate openLoginView];
}

- (IBAction)createNewAction:(id)sender {
    CreateJourneyViewController *createVC = [[CreateJourneyViewController alloc] initWithNibName:@"CreateJourneyViewController" bundle:nil];
    [self.navigationController pushViewController:createVC animated:YES];
}

@end
