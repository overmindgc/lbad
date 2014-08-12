//
//  JourneyTravelersView.m
//  lbad
//
//  Created by 辰 宫 on 14-8-11.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "JourneyTravelersView.h"
#import "TravelerVO.h"
#import "AppDelegate.h"

@implementation JourneyTravelersView
{
    NSArray *travelersSource;
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
    [self getTravelersList];
}


#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [travelersSource count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    static NSString *tableViewIndentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIndentifier];
    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    TravelerVO *tVO = [travelersSource objectAtIndex:row];
    cell.textLabel.text = tVO.user_name;
    cell.imageView.image = [UIImage imageNamed:tVO.user_portrait_url];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showSuccessWithStatus:@"别着急，我还没实现呢!"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}


#pragma mark service functions
- (void)getTravelersList
{
    [ApplicationDelegate.travelPlanService getSameRouteTravelerListByTravelId:@"1" completion:^(NSDictionary *resDict)
    {
         travelersSource = [resDict objectForKey:@"data"];
         [self.tableViewTraverler reloadData];
    }];
    
}

@end
