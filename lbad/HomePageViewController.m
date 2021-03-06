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
#import "TravelPlanVO.h"
#import "JourneyMainViewController.h"
#import "SettlementListViewController.h"

@interface HomePageViewController ()
{
    ButtonWithNumTipView *payListBtn;
    ButtonWithNumTipView *myLbBtn;
    ButtonWithNumTipView *messageBtn;
    
    /*进行中的旅程数据源*/
    NSArray *runningPlanSource;
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
    [self.createButton.layer setMasksToBounds:YES];
    [self.createButton.layer setCornerRadius:8.0f];
    [self.createButton.layer setBorderWidth:1.0f];
    
    self.refControl = [[UIRefreshControl alloc] init];
    self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_TIP_TEXT];
    [self.refControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    [self.tableViewPlan insertSubview:self.refControl atIndex:0];
    
    //创建三个图标
    NSInteger imgSize = 55;//图标大小
    float imgGap = ([UIScreen mainScreen].bounds.size.width - imgSize*3) / 4;
    payListBtn = [[ButtonWithNumTipView alloc] initWithFrame:CGRectMake(imgGap, 115, imgSize, imgSize)];
    payListBtn.btnText = @"账单";
    payListBtn.imgPath = @"paylist.png";
    [payListBtn addTarget:self action:@selector(payListOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payListBtn];
    
    myLbBtn = [[ButtonWithNumTipView alloc] initWithFrame:CGRectMake(imgGap*2+imgSize, 115, imgSize, imgSize)];
    myLbBtn.btnText = @"我的旅伴";
    myLbBtn.imgPath = @"peoples.png";
    [self.view addSubview:myLbBtn];
    
    messageBtn = [[ButtonWithNumTipView alloc] initWithFrame:CGRectMake(imgGap*3+imgSize*2, 115, imgSize, imgSize)];
    messageBtn.btnText = @"消息";
    messageBtn.imgPath = @"message.png";
    [self.view addSubview:messageBtn];
    
    //初始读取正在进行的计划列表
    [self getRunningPlanList];

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

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //如果是正在进行的列表
    if (section == 0) {
        return [runningPlanSource count];
    } else {//已结算旅程
        return 1;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    NSInteger row = indexPath.row;
    static NSString *tableViewIndentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIndentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (section == 0) {
        TravelPlanVO *tpVO = [runningPlanSource objectAtIndex:row];
        cell.textLabel.text = tpVO.description;
        cell.tag = 1;//标记1
    } else {
        cell.textLabel.text = @"已结算旅程";
        cell.tag = 2;//已结算标记2
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}// Default is 1 if not implemented

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //如果是正在进行的列表
    if (section == 0) {
        return 10;
    } else {//已结算旅程
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *currCell = [tableView cellForRowAtIndexPath:indexPath];
    currCell.selected = NO;
    
    if (currCell.tag == 2) {
        [SVProgressHUD showSuccessWithStatus:@"别着急，我还没实现呢!"];
    } else {
        TravelPlanVO *currTpVO = [runningPlanSource objectAtIndex:indexPath.row];
        JourneyMainViewController *journeyVC = [[JourneyMainViewController alloc] initWithNibName:@"JourneyMainViewController" bundle:nil];
        journeyVC.currTPVO = currTpVO;
        
        
        /* 过渡效果
         fade     //交叉淡化过渡(不支持过渡方向)
         push     //新视图把旧视图推出去
         moveIn   //新视图移到旧视图上面
         reveal   //将旧视图移开,显示下面的新视图
         cube     //立方体翻滚效果
         oglFlip  //上下左右翻转效果
         suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
         rippleEffect //滴水效果(不支持过渡方向)
         pageCurl     //向上翻页效果
         pageUnCurl   //向下翻页效果
         cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
         cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
         */
        
        /* 过渡方向
         fromRight;
         fromLeft;
         fromTop;
         fromBottom;
         */
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = @"oglFlip";
        transition.subtype = kCATransitionFromRight;
        transition.delegate = self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        [self.navigationController pushViewController:journeyVC animated:YES];
    }

}

#pragma mark service functions
- (void)getRunningPlanList
{
    [ApplicationDelegate.travelPlanService getRunningTravelPlanList:^(NSDictionary *resDict)
    {
        runningPlanSource = [resDict objectForKey:@"data"];
        [self.tableViewPlan reloadData];
        
        self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_TIP_TEXT];
        [self.refControl endRefreshing];
    }];
}


#pragma mark actions
- (IBAction)logoutAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate openLoginView];
}

- (IBAction)createNewAction:(id)sender {
    CreateJourneyViewController *createVC = [[CreateJourneyViewController alloc] initWithNibName:@"CreateJourneyViewController" bundle:nil];
    [self.navigationController pushViewController:createVC animated:YES];
}

- (void)refreshTableView
{
    if (self.refControl.refreshing) {
        self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_LOAD_DATA_TEXT];
        [self performSelector:@selector(getRunningPlanList) withObject:nil afterDelay:2];
    }
}

- (void)payListOnClick:(id)sender
{
    SettlementListViewController *settlementVC = [[SettlementListViewController alloc] initWithNibName:@"SettlementListViewController" bundle:nil];
    [self.navigationController pushViewController:settlementVC animated:YES];
}

@end
