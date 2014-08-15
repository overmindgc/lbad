//
//  JourneyExpendListView.m
//  lbad
//
//  Created by 辰 宫 on 14-8-11.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "JourneyExpendListView.h"
#import "CHTumblrMenuView.h"
#import "AppDelegate.h"
#import "ExpendVO.h"
#import "ExpendMoneyCell.h"
#import "TravelExpendTopCell.h"

@implementation JourneyExpendListView
{
    //消费列表页面总数据源
    NSArray *expendSouece;
    //清单列表数据源
    NSMutableArray *expendListArr;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    self.refControl = [[UIRefreshControl alloc] init];
    self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:@" "];
    [self.refControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    [self.tableViewExpend addSubview:self.refControl];
    
    [self getAllExpendList];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return expendListArr.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        NSDictionary *dict = [expendListArr objectAtIndex:section-1];
        NSString *key = [[dict allKeys] objectAtIndex:0];
        return [[dict objectForKey:key] count];
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
        TravelExpendTopCell *teCell = [[[NSBundle mainBundle] loadNibNamed:@"TravelExpendTopCell" owner:self options:nil] objectAtIndex:0];
        teCell.personalExpendLabel.text = [NSString stringWithFormat:@"个人支出 %@",[expendSouece objectAtIndex:0]];
        teCell.totalExpendLabel.text = [NSString stringWithFormat:@"实际消费 %@",[expendSouece objectAtIndex:1]];
        cell = teCell;
    } else {
        ExpendMoneyCell *emCell = [[[NSBundle mainBundle] loadNibNamed:@"ExpendMoneyCell" owner:self options:nil] objectAtIndex:0];
        NSDictionary *dict = [expendListArr objectAtIndex:section-1];
        NSString *key = [[dict allKeys] objectAtIndex:0];
        NSArray *currArr = [dict objectForKey:key];
        ExpendVO *epVO = [currArr objectAtIndex:row];
        emCell.tag = section;
        emCell.nameLabel.text = epVO.expend_name;
        emCell.moneyLabel.text = epVO.expend_money;
        emCell.peopleNumLabel.text = epVO.traveler_num;
        cell = emCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if (indexPath.section > 0) {
        [SVProgressHUD showSuccessWithStatus:@"别着急，我还没实现呢!"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if(section == 0) {
        return 40.0f;
    }  else {
        return 44.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    } else {
        return 20;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSDictionary *dict = [expendListArr objectAtIndex:section];
//    NSString *key = [[dict allKeys] objectAtIndex:0];
//    return key;
//}

//自定义section样式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    if (section > 0) {
        myView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, SCREEN_WIDTH-10, 22)];
        titleLabel.font = APP_FONT(13);
        NSDictionary *dict = [expendListArr objectAtIndex:section-1];
        NSString *key = [[dict allKeys] objectAtIndex:0];
        titleLabel.text = key;
        [myView addSubview:titleLabel];
    }
    return myView;
}


#pragma mark service functions
- (void)getAllExpendList
{
    [ApplicationDelegate.travelPlanService getAllExpendListDataByTravelId:@"1" completion:^(NSDictionary *resDict)
     {
         expendSouece = [resDict objectForKey:@"data"];
         
         if (expendSouece.count > 2) {
             //取出消费列表数据的日起分类keys
             expendListArr = [[NSMutableArray alloc] init];
             for (NSInteger i=0; i<expendSouece.count; i++) {
                 if (i > 1) {
                     NSDictionary *expendDict = [expendSouece objectAtIndex:i];
                     [expendListArr addObject:expendDict];
                 }
             }
         }
         
         [self.tableViewExpend reloadData];
         
         self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:@" "];
         [self.refControl endRefreshing];
     }];
    
}

#pragma mark actions

- (IBAction)accountAction:(id)sender {
    [self showMenu];
}


- (void)showMenu
{
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    [menuView addMenuItemWithTitle:@"住宿" andIcon:[UIImage imageNamed:@"post_type_bubble_text@2x.png"] andSelectedBlock:^{
        NSLog(@"Text selected");
    }];
    [menuView addMenuItemWithTitle:@"交通" andIcon:[UIImage imageNamed:@"post_type_bubble_photo@2x.png"] andSelectedBlock:^{
        NSLog(@"Photo selected");
    }];
    [menuView addMenuItemWithTitle:@"餐饮" andIcon:[UIImage imageNamed:@"post_type_bubble_quote@2x.png"] andSelectedBlock:^{
        NSLog(@"Quote selected");
        
    }];
    [menuView addMenuItemWithTitle:@"购物" andIcon:[UIImage imageNamed:@"post_type_bubble_link@2x.png"] andSelectedBlock:^{
        NSLog(@"Link selected");
        
    }];
    [menuView addMenuItemWithTitle:@"娱乐" andIcon:[UIImage imageNamed:@"post_type_bubble_chat@2x.png"] andSelectedBlock:^{
        NSLog(@"Chat selected");
        
    }];
    [menuView addMenuItemWithTitle:@"项目" andIcon:[UIImage imageNamed:@"post_type_bubble_video@2x.png"] andSelectedBlock:^{
        NSLog(@"Video selected");
        
    }];
    [menuView addMenuItemWithTitle:@"" andIcon:[UIImage imageNamed:@""] andSelectedBlock:^{
        NSLog(@"Block selected");
        
    }];
    [menuView addMenuItemWithTitle:@"其他" andIcon:[UIImage imageNamed:@"post_type_bubble_text@2x.png"] andSelectedBlock:^{
        NSLog(@"Other selected");
        
    }];
    
    [menuView show];
}

- (void)refreshTableView
{
    if (self.refControl.refreshing) {
        self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中..."];
        [self performSelector:@selector(getAllExpendList) withObject:nil afterDelay:2];
    }
}
@end
