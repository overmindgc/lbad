/**
 *  系统常量有关的宏
 **/
/*系统主色*/
#define  APP_MAIN_COLOR [UIColor colorWithRed:196.0f/255.0f green:42.0f/255.0f blue:22.0f/255.0f alpha:1]
/*系统字体*/
#define  APP_FONT(S) [UIFont fontWithName:@"HelveticaNeue" size:S]
/*系统字体-加粗*/
#define  APP_FONT_BOLD(S) [UIFont fontWithName:@"HelveticaNeue-Bold" size:S]
/*屏幕宽高*/
#define  SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define  SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
/*ApplicationDelegate实例*/
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)