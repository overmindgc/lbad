//
//  ButtonWithNumTipView.m
//  lbad
//
//  Created by 辰 宫 on 14-8-4.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "ButtonWithNumTipView.h"
#import "Consts.h"

#define PI 3.14159265358979323846

@implementation ButtonWithNumTipView
{
    float imgSize;
}

@synthesize btnType,btnNum,imgPath;
//@synthesize btnImgView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //图片大小为视图大小稍小
        imgSize = self.frame.size.width;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImage *btnImg = [UIImage imageNamed:imgPath];
//    [self setImage:btnImg forState:UIControlStateNormal];
    [self setBackgroundImage:btnImg forState:UIControlStateNormal];
//    [btnImgView setBackgroundColor:[Consts sharedInstance].MAIN_COLOR];
//    [self addSubview:btnImgView];
    
    UIView *cicleView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 15, -2, 18, 18)];
    cicleView.backgroundColor = [UIColor orangeColor];
    cicleView.layer.cornerRadius = 8.5;
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    numLab.text = @"6";
    numLab.font = [UIFont fontWithName:[Consts sharedInstance].FONT_NAME_BOLD size:12];
    numLab.textColor = [UIColor whiteColor];
    numLab.textAlignment = NSTextAlignmentCenter;
    [cicleView addSubview:numLab];
    [self addSubview:cicleView];
    
    
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    
//    CGContextAddEllipseInRect(con, CGRectMake(0,0,17,17));
//    
//    CGContextSetFillColorWithColor(con, [UIColor yellowColor].CGColor);
//    
//    CGContextFillPath(con);
}


@end
