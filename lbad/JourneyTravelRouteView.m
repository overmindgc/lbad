//
//  JourneyTravelRouteView.m
//  lbad
//
//  Created by 辰 宫 on 14-8-11.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "JourneyTravelRouteView.h"
#import "AppDelegate.h"
#import "TravelRouteCellVO.h"
#import "WeatherVO.h"
#import "TravelRouteCell.h"
#import "WeatherCell.h"
#import "TravelRouteTopCell.h"

@implementation JourneyTravelRouteView
{
    NSDictionary *travelRouteSource;
    NSArray *routeArr;
    NSArray *weatherArr;
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
    self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_TIP_TEXT];
    [self.refControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    [self.tableViewRoute insertSubview:self.refControl atIndex:0];
    
    [self getAllTravelRouteData];
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
        return routeArr.count;
    } else {
        return weatherArr.count;
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
        TravelRouteTopCell *topCell = [[[NSBundle mainBundle] loadNibNamed:@"TravelRouteTopCell" owner:self options:nil] objectAtIndex:0];
        topCell.tag = section;
        topCell.dayNumLabel.text = [travelRouteSource objectForKey:@"day_num"];
        topCell.dateRangeLabel.text = [travelRouteSource objectForKey:@"date_range"];
        cell = topCell;
    } else if (section == 1) {
        TravelRouteCell *trCell = [[[NSBundle mainBundle] loadNibNamed:@"TravelRouteCell" owner:self options:nil] objectAtIndex:0];
        TravelRouteCellVO *trVO = [routeArr objectAtIndex:row];
        trCell.tag = section;
        trCell.dateTypeLabel.text = trVO.route_date_type;
        trCell.timeDescLabel.text = trVO.route_time_dest;
        cell = trCell;
    } else {
        WeatherCell *wCell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherCell" owner:self options:nil] objectAtIndex:0];
        WeatherVO *wVO = [weatherArr objectAtIndex:row];
        wCell.placeLabel.text = wVO.place_name;
        wCell.weatherImgView.image = [UIImage imageNamed:WEATHER_PICTURE(wVO.weather_type)];
        wCell.descLabel.text = wVO.description;
        cell = wCell;
    }

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
        return 48.0f;
    } else if (section == 1){
        return 50.0f;
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
- (void)getAllTravelRouteData
{
    [ApplicationDelegate.travelPlanService getAllTravelRouteDataByTravelId:@"1" completion:^(NSDictionary *resDict)
     {
         travelRouteSource = [resDict objectForKey:@"data"];
         
         routeArr = [travelRouteSource objectForKey:@"route_array"];
         weatherArr = [travelRouteSource objectForKey:@"weather_array"];
         
         [self.tableViewRoute reloadData];
         
         self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_TIP_TEXT];
         [self.refControl endRefreshing];
         
     }];
    
}

#pragma mark actions
- (void)refreshTableView
{
    if (self.refControl.refreshing) {
        self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_LOAD_DATA_TEXT];
        [self performSelector:@selector(getAllTravelRouteData) withObject:nil afterDelay:2];
    }
}

@end
