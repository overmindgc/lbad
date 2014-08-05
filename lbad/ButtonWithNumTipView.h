//
//  ButtonWithNumTipView.h
//  lbad
//  首页的带数字提示的按钮组件
//  Created by 辰 宫 on 14-8-4.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonWithNumTipView : UIButton

@property (nonatomic,copy) NSString *btnType;

@property (nonatomic,copy) NSString *btnNum;

@property (nonatomic,copy) NSString *imgPath;

@property (nonatomic,copy) NSString *btnText;

//@property UIButton *btnImgView;

/*显示提示数字*/
- (void)showTipNumber:(NSString *)num;
/*隐藏提示数字*/
- (void)hideTipNumber;

@end
