//
//  JourneyMainViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-8-11.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "JourneyMainViewController.h"
#import "JourneyExpendListView.h"
#import "JourneyTravelersView.h"
#import "JourneyTravelRouteView.h"

@interface JourneyMainViewController ()
{
    //保存当前显示的view
    UIView *currShowView;
    //消费清单view
    JourneyExpendListView *jurExpendListView;
    //行程view
    JourneyTravelRouteView *jurTravelRouteView;
    //同程旅伴view
    JourneyTravelersView *jurTraversView;
    
}

@end

@implementation JourneyMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UISwipeGestureRecognizer * swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
        swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:swipeleft];
        UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:swipeRight];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //给标签添加点击手势
    UITapGestureRecognizer * tapRoute = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchRoute:)];
    self.routeLabel.userInteractionEnabled = YES;
    [self.routeLabel addGestureRecognizer:tapRoute];
    UITapGestureRecognizer * tapExpendList = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchExpendList:)];
    self.expendListLabel.userInteractionEnabled = YES;
    [self.expendListLabel addGestureRecognizer:tapExpendList];
    UITapGestureRecognizer * tapTravelers = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchTravelers:)];
    self.travelersLabel.userInteractionEnabled = YES;
    [self.travelersLabel addGestureRecognizer:tapTravelers];
    
    //获得nib视图数组
    NSArray *nib1 = [[NSBundle mainBundle]loadNibNamed:@"JourneyTravelRouteView" owner:self options:nil];
    jurTravelRouteView = [nib1 objectAtIndex:0];
    [jurTravelRouteView setFrame:CGRectMake(0, 96, SCREEN_WIDTH, SCREEN_HEIGHT - 96)];
    [jurTravelRouteView setHidden:YES];
    [self.view addSubview:jurTravelRouteView];
    
    //获得nib视图数组
    NSArray *nib2 = [[NSBundle mainBundle]loadNibNamed:@"JourneyExpendListView" owner:self options:nil];
    jurExpendListView = [nib2 objectAtIndex:0];
    [jurExpendListView setFrame:CGRectMake(0, 96, SCREEN_WIDTH, SCREEN_HEIGHT - 96)];
    [self.view addSubview:jurExpendListView];
    currShowView = jurExpendListView;
    
    //获得nib视图数组
    NSArray *nib3 = [[NSBundle mainBundle]loadNibNamed:@"JourneyTravelersView" owner:self options:nil];
    jurTraversView = [nib3 objectAtIndex:0];
    [jurTraversView setFrame:CGRectMake(0, 96, SCREEN_WIDTH, SCREEN_HEIGHT - 96)];
    [jurTraversView setHidden:YES];
    [self.view addSubview:jurTraversView];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.topTitleItem.title = self.currTPVO.description;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark actions

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchRoute:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self showViewFromRight:jurTravelRouteView];
}

- (void)touchExpendList:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if ([currShowView isEqual:jurTraversView]) {
        [self showViewFromRight:jurExpendListView];
    } else if ([currShowView isEqual:jurTravelRouteView]){
        [self showViewFromLeft:jurExpendListView];
    }
}

- (void)touchTravelers:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self showViewFromLeft:jurTraversView];
}

- (void)swipeleft:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if ([currShowView isEqual:jurExpendListView]) {
        [self showViewFromLeft:jurTraversView];
    } else if ([currShowView isEqual:jurTraversView]) {
        [self showViewFromLeft:jurTravelRouteView];
    } else if ([currShowView isEqual:jurTravelRouteView]){
        [self showViewFromLeft:jurExpendListView];
    }
}

- (void)swiperight:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if ([currShowView isEqual:jurExpendListView]) {
        [self showViewFromRight:jurTravelRouteView];
    } else if ([currShowView isEqual:jurTravelRouteView]) {
        [self showViewFromRight:jurTraversView];
    } else if ([currShowView isEqual:jurTraversView]){
        [self showViewFromRight:jurExpendListView];
    }
}

- (void)showViewFromLeft:(UIView *)showView
{
    if (![currShowView isEqual:showView]) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.2f;
        animation.type = kCATransitionPush;//设置上面4种动画效果
        animation.subtype = kCATransitionFromLeft;//设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
        [currShowView setHidden:YES];
        [currShowView.layer addAnimation:animation forKey:@"animationIDLeft"];
        
        
        CATransition *animation2 = [CATransition animation];
        animation2.duration = 0.1f;
        animation2.type = kCATransitionFade;//设置上面4种动画效果
        animation2.subtype = kCATransitionFromLeft;//设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
        [showView setHidden:NO];
        [showView.layer addAnimation:animation2 forKey:@"animationIDLeft"];
        
        [showView setHidden:NO];
        currShowView = showView;
    }
}

- (void)showViewFromRight:(UIView *)showView
{
    if (![currShowView isEqual:showView]) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.2f;
        animation.type = kCATransitionPush;//设置上面4种动画效果
        animation.subtype = kCATransitionFromRight;//设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
        [currShowView setHidden:YES];
        [currShowView.layer addAnimation:animation forKey:@"animationIDRight"];
        
        
        CATransition *animation2 = [CATransition animation];
        animation2.duration = 0.1f;
        animation2.type = kCATransitionFade;//设置上面4种动画效果
        animation2.subtype = kCATransitionFromRight;//设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
        [showView setHidden:NO];
        [showView.layer addAnimation:animation2 forKey:@"animationIDRight"];
        
        [showView setHidden:NO];
        currShowView = showView;
    }
}

@end
