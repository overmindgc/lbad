//
//  LbadDateSquare.m
//  lbad
//
//  Created by 辰 宫 on 14-7-29.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "LbadDateSquare.h"

@implementation LbadDateSquare

@synthesize squareType;
@synthesize descLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        squareType = SQUARE_TYPE_NORMAL;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    [self.layer setBorderWidth:0.0];
//    [self.layer setBorderColor:[[UIColor grayColor] CGColor]];
    switch (squareType) {
        case SQUARE_TYPE_NORMAL:
            [self setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            break;
        case SQUARE_TYPE_EXPIRED:
            [self setTitleColor:[UIColor colorWithWhite:0.8 alpha:1.0] forState:UIControlStateNormal];
            break;
        case SQUARE_TYPE_NEXTOREXPIRED:
            [self setTitleColor:[UIColor colorWithWhite:0.3 alpha:1.0] forState:UIControlStateNormal];
            break;
        default:
            [self setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            break;
    }
    [self.titleLabel setFont:APP_FONT_BOLD(16)];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

- (void)setSelectedWith:(NSString *)descText andColor:(UIColor *)bgColor
{
    if (bgColor == nil) {
        bgColor = APP_MAIN_COLOR;
    }
    self.selected = YES;
    [self setBackgroundColor:bgColor];
    [self setDescLabelWith:descText];
}

- (void)setUnSelected
{
    self.selected = NO;
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setDescLabelWith:nil];
}

//设置标签
- (void)setDescLabelWith:(NSString *)descText
{
    //描述文字nil，则删除label组件
    if (descText != nil) {
        if (descLabel != nil) {
            [descLabel removeFromSuperview];
        }
        descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 18, self.frame.size.width - 2, 18)];
        //    descLabel.text = defaultDescText;
        [descLabel setFont:APP_FONT_BOLD(11)];
        if ([descText isEqualToString:@"启程"]) {
            [descLabel setFont:APP_FONT_BOLD(12)];
        } else if ([descText isEqualToString:@"返程"]) {
            [descLabel setFont:APP_FONT_BOLD(12)];
        }
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.text = descText;
        descLabel.textColor = [UIColor whiteColor];
        [self addSubview:descLabel];
    } else {
        if (descLabel != nil) {
            [descLabel removeFromSuperview];
        }
    }
    
}

@end
