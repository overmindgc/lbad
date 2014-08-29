//
//  AccountListViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-8-27.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "AccountListViewController.h"
#import "AppDelegate.h"
#import "AccountTotalCell.h"
#import "ExpendMoneyCell.h"
#import "ExpendVO.h"
#import "ExpendDetailViewController.h"

@interface AccountListViewController ()
{
    NSMutableDictionary *accountListSource;
    
    NSMutableArray *myPayArr;
    
    NSMutableArray *hePayArr;
}

@end

@implementation AccountListViewController

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
    
    self.refControl = [[UIRefreshControl alloc] init];
    self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_TIP_TEXT];
    [self.refControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refControl atIndex:0];
    
    [self getAccountListData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger totalSection = myPayArr.count + hePayArr.count + 1;
    return totalSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    if (section > 0 && section < myPayArr.count + 1) {
        return [[myPayArr objectAtIndex:section - 1] count] - 1;
    }
    
    if (section > myPayArr.count) {
        return [[hePayArr objectAtIndex:section - myPayArr.count - 1] count] - 1;
    }
    
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell;
    
    if (section == 0) {
        AccountTotalCell *topCell = [[[NSBundle mainBundle] loadNibNamed:@"AccountTotalCell" owner:self options:nil] objectAtIndex:0];
        topCell.tag = section;
        topCell.descLabel.text = [NSString stringWithFormat:@"核算后需要%@ %@",self.payOrCollectionName,[accountListSource objectForKey:@"payfor_name"]];
        topCell.amountLabel.text = [accountListSource objectForKey:@"payfor_amount"];
        cell = topCell;
    } else if (section > 0 && section < myPayArr.count + 1) {
        ExpendMoneyCell *myPayCell = [[[NSBundle mainBundle] loadNibNamed:@"ExpendMoneyCell" owner:self options:nil] objectAtIndex:0];
        myPayCell.tag = section;
        ExpendVO *myExp = [[myPayArr objectAtIndex:section - 1] objectAtIndex:row + 1];
        myPayCell.nameLabel.text = myExp.expend_name;
        myPayCell.moneyLabel.text = myExp.expend_money;
        myPayCell.peopleNumLabel.text = myExp.traveler_num;
        cell = myPayCell;
    } else {
        ExpendMoneyCell *hePayCell = [[[NSBundle mainBundle] loadNibNamed:@"ExpendMoneyCell" owner:self options:nil] objectAtIndex:0];
        hePayCell.tag = section;
        ExpendVO *heExp = [[hePayArr objectAtIndex:section - myPayArr.count - 1] objectAtIndex:row + 1];
        hePayCell.nameLabel.text = heExp.expend_name;
        hePayCell.moneyLabel.text = heExp.expend_money;
        hePayCell.peopleNumLabel.text = heExp.traveler_num;
        cell = hePayCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        ExpendDetailViewController *edVC = [[ExpendDetailViewController alloc] initWithNibName:@"ExpendDetailViewController" bundle:nil];
        ExpendMoneyCell *emCell = (ExpendMoneyCell *)[tableView cellForRowAtIndexPath:indexPath];
        edVC.titleName = emCell.nameLabel.text;
        [self.navigationController pushViewController:edVC animated:YES];
    }
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if(section == 0) {
        return 70.0f;
    } else {
        return 44.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    } else {
        if (section == 1 || section == myPayArr.count + 1) {
            return 40;
        } else {
             return 20;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

//自定义section样式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if (section > 0 && section < myPayArr.count + 1) {
        if (section == 1) {
            UIView *totalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
            totalView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
            UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 180, 20)];
            payLabel.text = @"我支付的消费清单";
            payLabel.font = APP_FONT(13);
            payLabel.textColor = [UIColor whiteColor];
            UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 0, 110, 20)];
            amountLabel.font = APP_FONT(13);
            amountLabel.textColor = [UIColor whiteColor];
            amountLabel.text = [accountListSource objectForKey:@"my_pay_amount"];
            [totalView addSubview:payLabel];
            [totalView addSubview:amountLabel];
            
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 20, SCREEN_WIDTH-10, 20)];
            dateLabel.font = APP_FONT(13);
            dateLabel.text = [[myPayArr objectAtIndex:section - 1] objectAtIndex:0];
            [myView addSubview:totalView];
            [myView addSubview:dateLabel];
        } else {
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, SCREEN_WIDTH-10, 20)];
            dateLabel.font = APP_FONT(13);
            dateLabel.text = [[myPayArr objectAtIndex:section - 1] objectAtIndex:0];
            [myView addSubview:dateLabel];
        }
        
    } else if (section > myPayArr.count) {
        if (section == myPayArr.count + 1) {
            UIView *totalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
            totalView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
            UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 180, 20)];
            payLabel.text = [NSString stringWithFormat:@"%@支付的消费清单",[accountListSource objectForKey:@"payfor_name"]];
            payLabel.font = APP_FONT(13);
            payLabel.textColor = [UIColor whiteColor];
            UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 0, 110, 20)];
            amountLabel.font = APP_FONT(13);
            amountLabel.textColor = [UIColor whiteColor];
            amountLabel.text = [accountListSource objectForKey:@"my_pay_amount"];
            [totalView addSubview:payLabel];
            [totalView addSubview:amountLabel];
            
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 20, SCREEN_WIDTH-10, 20)];
            dateLabel.font = APP_FONT(13);
            dateLabel.text = [[myPayArr objectAtIndex:section - myPayArr.count - 1] objectAtIndex:0];
            [myView addSubview:totalView];
            [myView addSubview:dateLabel];
        } else {
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, SCREEN_WIDTH-10, 20)];
            dateLabel.font = APP_FONT(13);
            dateLabel.text = [[hePayArr objectAtIndex:section - myPayArr.count - 1] objectAtIndex:0];
            [myView addSubview:dateLabel];
        }
    }
    
    return myView;
}

#pragma mark service functions
- (void)getAccountListData
{
    [ApplicationDelegate.billService getAccountListDataById:nil completion:^(NSDictionary *resDict)
     {
         accountListSource = [resDict objectForKey:@"data"];
         
         myPayArr = [accountListSource objectForKey:@"my_pay_list"];
         hePayArr = [accountListSource objectForKey:@"he_pay_list"];
         
         [self.tableView reloadData];
         
         self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_TIP_TEXT];
         [self.refControl endRefreshing];
     }];
    
}

#pragma mark actions

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshTableView
{
    if (self.refControl.refreshing) {
        self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_LOAD_DATA_TEXT];
        [self performSelector:@selector(getAccountListData) withObject:nil afterDelay:2];
    }
}
@end
