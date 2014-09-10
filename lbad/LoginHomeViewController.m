//
//  LoginHomeViewController.m
//  lbad
//
//  Created by 辰 宫 on 14-7-25.
//  Copyright (c) 2014年 gc. All rights reserved.
//
#import "AppDelegate.h"
#import "LoginHomeViewController.h"

@interface LoginHomeViewController ()

@end

@implementation LoginHomeViewController

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
    self.loginQQBtn.backgroundColor = APP_MAIN_COLOR;
    [self.loginQQBtn.layer setCornerRadius:10.0f];
    [self.registerButton.layer setCornerRadius:10.0f];
    
    [self.loginBtn setFrame:CGRectMake(SCREEN_WIDTH/2 - self.loginBtn.frame.size.width/2, SCREEN_HEIGHT - 66, self.loginBtn.frame.size.width, self.loginBtn.frame.size.height)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    [ApplicationDelegate.loginService doLoginWithUserName:@"qd_admin" password:@"qd_admin" completeBlock:loginCompBlock];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate openHomeView];
}

void(^loginCompBlock)(NSDictionary *resDict) = ^(NSDictionary *resDict)
{
    NSLog(@"%@",resDict);
};



@end
