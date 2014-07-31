//
//  CreateJourneyViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-7-25.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "CreateJourneyViewController.h"
#import "LbadDateSelectorViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface CreateJourneyViewController ()

@end

@implementation CreateJourneyViewController

@synthesize labelDate;

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
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelDateTaped:)];
    labelDate.userInteractionEnabled = YES;
    tapGr.numberOfTapsRequired = 1;
    tapGr.numberOfTouchesRequired = 1;
    [labelDate addGestureRecognizer:tapGr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions

- (IBAction)backToHomeAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)labelDateTaped:(UITapGestureRecognizer *)sender
{
    LbadDateSelectorViewController *dateSelector = [[LbadDateSelectorViewController alloc] init];
    [self presentPopupViewController:dateSelector animationType:MJPopupViewAnimationSlideBottomBottom];
}

@end
