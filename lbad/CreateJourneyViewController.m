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
#import "DateUtils.h"
#import "AreaSingleSelectViewController.h"

@interface CreateJourneyViewController ()

@end

@implementation CreateJourneyViewController

@synthesize dateLabel;

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
    //监听点击选择日期label
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateLabelTaped:)];
    dateLabel.userInteractionEnabled = YES;
    tapGr.numberOfTapsRequired = 1;
    tapGr.numberOfTouchesRequired = 1;
    [dateLabel addGestureRecognizer:tapGr];
    
    //键盘弹出时点击其他地方就收起
    UITapGestureRecognizer *tapGrBlank = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    self.view.userInteractionEnabled = YES;
    tapGrBlank.numberOfTapsRequired = 1;
    tapGrBlank.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGrBlank];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark LbadCalendarDelegates

/*完成日期选择回调*/
- (void)selectedOn:(NSDate *)beginDate to:(NSDate *)endDate withSize:(NSInteger)size
{
    if (size == 0) {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    } else {
        NSString *beginStr = [DateUtils dateToString:@"M月d日" date:beginDate];
        NSString *endStr = [DateUtils dateToString:@"M月d日" date:endDate];
        dateLabel.text = [NSString stringWithFormat:@"%@ 至 %@ %ld天",beginStr,endStr,size];
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self dismissKeyBoard];
    return YES;
}

#pragma mark actions

- (IBAction)backToHomeAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectCityAction:(id)sender {
    AreaSingleSelectViewController *areaVC = [[AreaSingleSelectViewController alloc] initWithNibName:@"AreaSingleSelectViewController" bundle:nil];
    areaVC.selectDelegate = self;
    [self.navigationController pushViewController:areaVC animated:YES];
}

- (void)dateLabelTaped:(UITapGestureRecognizer *)sender
{
    [self dismissKeyBoard];
    LbadDateSelectorViewController *dateSelector = [[LbadDateSelectorViewController alloc] init];
    dateSelector.delegate = self;
    [self presentPopupViewController:dateSelector animationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)dismissKeyBoard
{
    if ([self.textFieldDesc isFirstResponder]) {
        [self.textFieldDesc resignFirstResponder];
    }
}

#pragma mark citySelectDelegate
- (void)selectCity:(NSString *)cityName
{
    NSLog(@"%@",cityName);
    [self.navigationController popToViewController:self animated:YES];
    self.destinationLabel.text = cityName;
}

#pragma mark utils
//-(void)showKeyBoardTopView{
//    UIToolbar * topKeyboardView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
//    [topKeyboardView setBarStyle:UIBarStyleBlackOpaque];
//    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"取消",nil,nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
//    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
//    [topKeyboardView setItems:buttonsArray];
//    
//    [self.textFieldDesc setInputAccessoryView:topKeyboardView];
//}

@end
