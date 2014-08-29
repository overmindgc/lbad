//
//  ExpendDetailViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-8-29.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "ExpendDetailViewController.h"
#import "TravelerCell.h"
#import "TravelerVO.h"

@interface ExpendDetailViewController ()
{
    NSArray *travelersSource;
}

@end

@implementation ExpendDetailViewController

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
    TravelerVO *t1 = [[TravelerVO alloc] init];
    t1.user_id = @"1";
    t1.user_name = @"刘强";
    t1.user_portrait_url = @"liuqiang.png";
    TravelerVO *t2 = [[TravelerVO alloc] init];
    t2.user_id = @"2";
    t2.user_name = @"李强";
    t2.user_portrait_url = @"liuqiang.png";
    TravelerVO *t3 = [[TravelerVO alloc] init];
    t3.user_id = @"3";
    t3.user_name = @"王宝强";
    t3.user_portrait_url = @"wangbaoqiang.jpeg";
    
    travelersSource = [NSArray arrayWithObjects:t1,t2,t3, nil];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 70, 0, 11);
}

- (void)viewWillAppear:(BOOL)animated
{
    self.topTitleItem.title = self.titleName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
