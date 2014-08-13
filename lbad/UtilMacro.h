/**
 *  常用工具宏
 */
#define PI 3.14159265358979323846

/*根据RGB获取颜色*/
#define  RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define  RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
/*rgb颜色转换（16进制->10进制）*/
#define  UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/*天气类型和对应图片字典*/
#define WEATHER_PICTURE(type) [[NSDictionary dictionaryWithObjectsAndKeys:@"snow.png",@"snow",@"sunny.png",@"sunny",@"thunder.png",@"thunder",@"cloudsun.png",@"cloudsun",@"torrentrain.png",@"torrentrain", nil] objectForKey:type]