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

@implementation JourneyExpendListView
{
    //消费列表页面总数据源
    NSDictionary *expendDictSouece;
    
    NSMutableArray *expendDateArr;
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
    [self getAllExpendList];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [expendDateArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [expendDateArr objectAtIndex:section];
    return [[expendDictSouece objectForKey:key] count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSString *key = [expendDateArr objectAtIndex:section];
    
    NSInteger row = indexPath.row;
    static NSString *tableViewIndentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIndentifier];
    }
    [cell.textLabel setFont:APP_FONT(15)];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray *currArr = [expendDictSouece objectForKey:key];
    ExpendVO *epVO = [currArr objectAtIndex:row];
    cell.tag = section;
    cell.textLabel.text = [NSString stringWithFormat:@"%@           %@  %@",epVO.expendName,epVO.expendMoney,epVO.travelerNum];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showSuccessWithStatus:@"别着急，我还没实现呢!"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [expendDateArr objectAtIndex:section];
}

//自定义section样式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, 22)];
    titleLabel.font = APP_FONT(13);
    titleLabel.text=[expendDateArr objectAtIndex:section];
    [myView addSubview:titleLabel];
    return myView;
}


#pragma mark service functions
- (void)getAllExpendList
{
    [ApplicationDelegate.travelPlanService getAllExpendListDataByTravelId:@"1" completion:^(NSDictionary *resDict)
     {
         expendDictSouece = [resDict objectForKey:@"data"];
         
         if (expendDictSouece.count >= 2) {
             //设置个人和全部数据
             self.personalExpendLabel.text = [NSString stringWithFormat:@"个人支出 %@",[expendDictSouece objectForKey:@"personalMonay"]];
             self.totalExpendLabel.text = [NSString stringWithFormat:@"实际消费 %@",[expendDictSouece objectForKey:@"totalMonay"]];
             
             //取出消费列表数据的日起分类keys
             expendDateArr = [[NSMutableArray alloc] init];
             NSArray *keyArr = [expendDictSouece allKeys];
             for (NSInteger i=0; i<keyArr.count; i++) {
                 NSString *key = [keyArr objectAtIndex:i];
                 if (![key isEqualToString:@"personalMonay"] && ![key isEqualToString:@"totalMonay"]) {
                     [expendDateArr addObject:[keyArr objectAtIndex:i]];
                 }
             }
         }
         
         [self.tableViewExpend reloadData];
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
@end
