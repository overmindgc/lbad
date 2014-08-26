//
//  SettlementListViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-8-26.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "SettlementListViewController.h"
#import "AppDelegate.h"

@interface SettlementListViewController ()
{
    NSDictionary *listSourceDict;
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
//    if (section == 0) {
        return 1;
//    } else if (section == 1) {
//        return routeArr.count;
//    } else {
//        return weatherArr.count;
//    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell;
    
//    if (section == 0) {
//        TravelRouteTopCell *topCell = [[[NSBundle mainBundle] loadNibNamed:@"TravelRouteTopCell" owner:self options:nil] objectAtIndex:0];
//        topCell.tag = section;
//        topCell.dayNumLabel.text = [travelRouteSource objectForKey:@"day_num"];
//        topCell.dateRangeLabel.text = [travelRouteSource objectForKey:@"date_range"];
//        cell = topCell;
//    } else if (section == 1) {
//        TravelRouteCell *trCell = [[[NSBundle mainBundle] loadNibNamed:@"TravelRouteCell" owner:self options:nil] objectAtIndex:0];
//        TravelRouteCellVO *trVO = [routeArr objectAtIndex:row];
//        trCell.tag = section;
//        trCell.dateTypeLabel.text = trVO.route_date_type;
//        trCell.timeDescLabel.text = trVO.route_time_dest;
//        cell = trCell;
//    } else {
//        WeatherCell *wCell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherCell" owner:self options:nil] objectAtIndex:0];
//        WeatherVO *wVO = [weatherArr objectAtIndex:row];
//        wCell.placeLabel.text = wVO.place_name;
//        wCell.weatherImgView.image = [UIImage imageNamed:WEATHER_PICTURE(wVO.weather_type)];
//        wCell.descLabel.text = wVO.description;
//        cell = wCell;
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
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

#pragma mark service functions
- (void)getSettlementListData
{
    [ApplicationDelegate.billService getSettlementListData:^(NSDictionary *resDict)
     {
         listSourceDict = [resDict objectForKey:@"data"];
         
//         routeArr = [travelRouteSource objectForKey:@"route_array"];
//         weatherArr = [travelRouteSource objectForKey:@"weather_array"];
//         
//         [self.tableViewRoute reloadData];
//         
//         self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:@" "];
//         [self.refControl endRefreshing];
     }];
    
}


#pragma mark actions
- (IBAction)clearAllSettlement:(id)sender
{
    
}

@end
