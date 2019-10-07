//
//  App_Header_Define.h
//  App_General_Template
//
//  Created by JXH on 2017/6/27.
//  Copyright © 2017年 JXH. All rights reserved.
//

#ifndef App_Header_Define_h
#define App_Header_Define_h

//  是否是iPhoneX
#define iPhoneX (([UIScreen mainScreen].bounds.size.height / [UIScreen mainScreen].bounds.size.width) > 1.78 ? YES : NO)
//  状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
//  导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
//  TabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
//  Home Indicator高度
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

//  比例宽
#define RATEWIDTH_iPhone6(WIDTH) (WIDTH/375.0) * [[UIScreen mainScreen] bounds].size.width
//  比例高
#define RATEHEIGHT_iPhone6(HEIGHT) (HEIGHT/667.0) * [[UIScreen mainScreen] bounds].size.height
//  屏幕宽高：YYkit 中定义，因此注释
//#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//  打印输出
#ifdef DEBUG
#define JLog(Format, ...) fprintf(stderr,"%s: %s->%d\n%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __FUNCTION__, __LINE__, [[NSString stringWithFormat:Format, ##__VA_ARGS__] UTF8String])
#else
#define JLog(Format, ...)
#endif

//  Font:字体&大小
#define FontName_Size(fontName, fontSize)      (fontName).length ? [UIFont fontWithName:fontName size:fontSize] : FontSystem(fontSize)
#define Font(fontSize)      [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize]
#define FontBold(fontSize)      [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize]
#define FontSystem(fontSize)      [UIFont systemFontOfSize:fontSize]
#define FontSystemBold(fontSize)  [UIFont boldSystemFontOfSize:fontSize]

//  Color:颜色
#define RandomColor         Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define Color(r, g, b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ColorRGBA(r, g, b, alpha)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:alpha]
#define UIColorHex_Aphpa(hex,alpha)   [UIColor hexStringToColor:hex alpha:alpha]
#define UIColorHexStr(hex)   [UIColor hexStringToColor:hex]

//  App 配置
#define APP_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_Channel @"AppStore"


//  NSUserDefaults
#define  UD [NSUserDefaults standardUserDefaults]
#define  UD_SET(_Value,_Key)   [UD setObject:_Value forKey:_Key]
#define  UD_GET(_Key)  [UD objectForKey:_Key]
#define  SharedApplication  [UIApplication sharedApplication]
//  添加圆角
#define XHBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:Color.CGColor]

//系统globalQueue
#define JGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#endif /* App_Header_Define_h */
