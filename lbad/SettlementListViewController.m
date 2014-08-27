//
//  SettlementListViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-8-26.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "SettlementListViewController.h"
#import "AppDelegate.h"
#import "TotalPanCountCell.h"
#import "PaymentAmountCell.h"
#import "CollectionAmountCell.h"

@interface SettlementListViewController ()
{
    NSDictionary *listSourceDict;
    
    NSMutableArray *paymentArray;

    NSMutableArray *collectionArray;
}

@end

@implementation SettlementListViewController

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
    
    [self getSettlementListData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return paymentArray.count;
    } else {
        return collectionArray.count;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell;
    
    if (section == 0) {
        TotalPanCountCell *topCell = [[[NSBundle mainBundle] loadNibNamed:@"TotalPanCountCell" owner:self options:nil] objectAtIndex:0];
        topCell.tag = section;
        topCell.paymentLabel.text = [listSourceDict objectForKey:@"payment"];
        topCell.collectionLabel.text = [listSourceDict objectForKey:@"collection"];
        cell = topCell;
    } else if (section == 1) {
        PaymentAmountCell *payCell = [[[NSBundle mainBundle] loadNibNamed:@"PaymentAmountCell" owner:self options:nil] objectAtIndex:0];
        payCell.tag = section;
        NSDictionary *dp = [paymentArray objectAtIndex:row];
        payCell.nameLabel.text = [dp objectForKey:@"name"];
        payCell.amountLabel.text = [dp objectForKey:@"amount"];
        cell = payCell;
    } else {
        CollectionAmountCell *colCell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionAmountCell" owner:self options:nil] objectAtIndex:0];
        NSDictionary *dc = [collectionArray objectAtIndex:row];
        colCell.nameLabel.text = [dc objectForKey:@"name"];
        colCell.amountLabel.text = [dc objectForKey:@"amount"];
        cell = colCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        [SVProgressHUD showSuccessWithStatus:@"别着急，我还没实现呢!"];
    }
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if(section == 0) {
        return 95.0f;
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
        return 5;
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
    return myView;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"清帐";
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deleteSettlementBy:indexPath.row inSection:indexPath.section];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark service functions
- (void)getSettlementListData
{
    [ApplicationDelegate.billService getSettlementListData:^(NSDictionary *resDict)
     {
         listSourceDict = [resDict objectForKey:@"data"];
         
         paymentArray = [listSourceDict objectForKey:@"payment_array"];
         collectionArray = [listSourceDict objectForKey:@"colletion_array"];
         
         [self.tableView reloadData];
         
         self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_TIP_TEXT];
         [self.refControl endRefreshing];
     }];
    
}

//清帐删除一条记录
- (void)deleteSettlementBy:(NSInteger)index inSection:(NSInteger)section
{
    if (section == 1) {
        [paymentArray removeObjectAtIndex:index];
    } else if (section == 2)
    {
        [collectionArray removeObjectAtIndex:index];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark actions

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clearAllSettlement:(id)sender
{
    
}

- (void)refreshTableView
{
    if (self.refControl.refreshing) {
        self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_LOAD_DATA_TEXT];
        [self performSelector:@selector(getSettlementListData) withObject:nil afterDelay:2];
    }
}

@end
