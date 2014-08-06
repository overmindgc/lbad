//
//  ButtonWithNumTipView.m
//  lbad
//
//  Created by 辰 宫 on 14-8-4.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "ButtonWithNumTipView.h"

@implementation ButtonWithNumTipView
{
    UIView *cicleView;
    UILabel *numLab;
}

@synthesize btnType,btnNum,imgPath,btnText;
//@synthesize btnImgView;

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
    UIImage *btnImg = [UIImage imageNamed:imgPath];
    [self setImage:btnImg forState:UIControlStateNormal];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(-5, self.frame.size.height, self.frame.size.width+10, 25)];
    textLabel.text = btnText;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = APP_FONT_BOLD(15);
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textLabel];
    
    cicleView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 15, -2, 18, 18)];
    cicleView.backgroundColor = [UIColor orangeColor];
    cicleView.layer.cornerRadius = 8.5;
    [cicleView setHidden:YES];
    
    numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    numLab.font = APP_FONT_BOLD(12);
    numLab.textColor = [UIColor whiteColor];
    numLab.textAlignment = NSTextAlignmentCenter;
    [numLab setHidden:YES];
    [cicleView addSubview:numLab];
    [self addSubview:cicleView];
    
}

- (void)showTipNumber:(NSString *)num;
{
    numLab.text = num;
    
    CGAffineTransform smallTransform = CGAffineTransformMakeScale(0.1, 0.1);
    [cicleView setTransform:smallTransform];
    [numLab setTransform:smallTransform];
    
    [cicleView setHidden:NO];
    [numLab setHidden:NO];
    
    [UIView animateWithDuration:0.15 animations:^{
        CGAffineTransform originTransform = CGAffineTransformMakeScale(1.0, 1.0);
        [cicleView setTransform:originTransform];
        [numLab setTransform:originTransform];
    }];
}

- (void)hideTipNumber
{
    [cicleView setHidden:YES];
    [numLab setHidden:YES];
}

@end
