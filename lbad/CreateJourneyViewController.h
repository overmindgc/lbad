//
//  CreateJourneyViewController.h
//  lbad
//
//  Created by 辰 宫 on 14-7-25.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LbadCalendarDelegate.h"
#import "CitySelectDelegate.h"

@interface CreateJourneyViewController : UIViewController <UIActionSheetDelegate,UITextFieldDelegate,LbadCalendarDelegate,CitySelectDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDesc;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;

@end
