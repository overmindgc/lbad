//
//  CreateJourneyViewController.h
//  lbad
//
//  Created by 辰 宫 on 14-7-25.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LbadCalendarDelegate.h"

@interface CreateJourneyViewController : UIViewController <UIActionSheetDelegate,LbadCalendarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@end
