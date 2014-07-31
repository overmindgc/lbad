//
//  HomePageViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-7-25.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "CreateJourneyViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate openLoginView];
}

- (IBAction)createNewAction:(id)sender {
    CreateJourneyViewController *createVC = [[CreateJourneyViewController alloc] initWithNibName:@"CreateJourneyViewController" bundle:nil];
    [self.navigationController pushViewController:createVC animated:YES];
}

@end
