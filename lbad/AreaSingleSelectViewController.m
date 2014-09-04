//
//  AreaSingleSelectViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-8-19.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "AreaSingleSelectViewController.h"
#import "AppDelegate.h"
#import "CitySingleSelectViewController.h"

@interface AreaSingleSelectViewController ()
{
    
    NSMutableDictionary *areaSourceDict;
    //记录完整的数据源，用于结束搜索时恢复
    NSMutableDictionary *originAreaSourceDict;
}

@property (nonatomic, strong) UISearchDisplayController *searchController;

@end

@implementation AreaSingleSelectViewController

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
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    [self getAreaSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return areaSourceDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *provinceDict = [areaSourceDict objectForKey:@"0"];
    if (areaSourceDict.count == 0) {
        return provinceDict.count;
    } else {
        if (section == 0) {
            NSDictionary *citysDict = [areaSourceDict objectForKey:@"1"];
            return citysDict.count;
        } else {
            return provinceDict.count;
        }
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
    cell.textLabel.font = APP_FONT(16);
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.tag = 1;
    NSString *cellText = @"";
    NSDictionary *provinceDict = [areaSourceDict objectForKey:@"0"];
    if (areaSourceDict.count == 0) {
        cellText = [provinceDict objectForKey:[NSString stringWithFormat:@"%ld",row]];
    } else {
        if (section == 0) {
            NSDictionary *citysDict = [areaSourceDict objectForKey:@"1"];
            cellText = [citysDict objectForKey:[NSString stringWithFormat:@"%ld",row]];
            cell.tag = 1;
        } else {
            NSDictionary *oneProvinceDict = [provinceDict objectForKey:[NSString stringWithFormat:@"%ld",row]];
            cellText = [[oneProvinceDict allKeys] objectAtIndex:0];
            NSDictionary *citysDict = [oneProvinceDict objectForKey:cellText];
            if (citysDict.count > 1) {
                cell.tag = 2;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
    }
    cell.textLabel.text = cellText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    
    NSDictionary *provinceDict = [areaSourceDict objectForKey:@"0"];
    NSDictionary *oneProvinceDict = [provinceDict objectForKey:[NSString stringWithFormat:@"%ld",row]];
    NSString *provinceName = [[oneProvinceDict allKeys] objectAtIndex:0];
    NSDictionary *citysDict = [oneProvinceDict objectForKey:provinceName];
    if (cell.tag == 2) {
        CitySingleSelectViewController *cityVC = [[CitySingleSelectViewController alloc] initWithNibName:@"CitySingleSelectViewController" bundle:nil];
        cityVC.selectDelegate = self.selectDelegate;
        cityVC.titleText = provinceName;
        cityVC.citySourceDict = citysDict;
        [self.navigationController pushViewController:cityVC animated:YES];
    } else {
        [self.selectDelegate selectCity:cell.textLabel.text];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

//自定义section样式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, SCREEN_WIDTH-10, 20)];
    titleLabel.font = APP_FONT(13);

    if (areaSourceDict.count == 0) {
        titleLabel.text = @"全国";
    } else {
        if (section == 0) {
            titleLabel.text = @"最近去过的城市";
        } else {
            titleLabel.text = @"全国";
        }
    }
    [myView addSubview:titleLabel];
    return myView;
}

#pragma mark - Search Bar delegate funciton

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    //清空重置
    self.searchBar.text = @"";
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
    
    [self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //按软键盘右下角的搜索按钮时触发
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton = NO;
    
    [self.tableView reloadData];
}

#pragma mark source and services
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getAreaSource
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    NSDictionary *originDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    areaSourceDict = [[NSMutableDictionary alloc] init];
    [areaSourceDict setValue:originDict forKey:@"0"];
    [self.tableView reloadData];
    [ApplicationDelegate.travelPlanService getRecentlyArrivedPlace:^(NSDictionary *resDict){
        [areaSourceDict setValue:[resDict objectForKey:@"data"] forKey:@"1"];
        [self.tableView reloadData];
    }];
    
    
}

@end
