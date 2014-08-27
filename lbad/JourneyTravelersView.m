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
#import "TravelerCell.h"

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
    
    self.refControl = [[UIRefreshControl alloc] init];
    self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_TIP_TEXT];
    [self.refControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    [self.tableViewTraverler insertSubview:self.refControl atIndex:0];
    
    [self getTravelersList];
    
    self.tableViewTraverler.separatorInset = UIEdgeInsetsMake(0, 70, 0, 11);
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
    
    TravelerCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIndentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TravelerCell" owner:self options:nil] objectAtIndex:0];
    }
    
    TravelerVO *tVO = [travelersSource objectAtIndex:row];
    cell.nameLabel.text = tVO.user_name;
    UIImage *portraitImage = [UIImage imageNamed:tVO.user_portrait_url];
    cell.portraitImageView.image = portraitImage;
    cell.portraitImageView.layer.masksToBounds = YES;
    cell.portraitImageView.layer.cornerRadius = 19;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    [SVProgressHUD showSuccessWithStatus:@"别着急，我还没实现呢!"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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
        
        self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_TIP_TEXT];
        [self.refControl endRefreshing];
    }];
    
}


#pragma mark actions
- (void)refreshTableView
{
    if (self.refControl.refreshing) {
        self.refControl.attributedTitle = [[NSAttributedString alloc] initWithString:PULL_LOAD_DATA_TEXT];
        [self performSelector:@selector(getTravelersList) withObject:nil afterDelay:2];
    }
}

@end
