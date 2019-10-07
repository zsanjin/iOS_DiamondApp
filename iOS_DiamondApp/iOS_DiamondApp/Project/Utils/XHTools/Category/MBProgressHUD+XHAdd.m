//
//  MBProgressHUD+XHAdd.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/14.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "MBProgressHUD+XHAdd.h"

@implementation MBProgressHUD (XHAdd)
#pragma mark 显示信息

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view duration:(CGFloat)duration{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // x秒之后再消失
    [hud hideAnimated:YES afterDelay:duration>0?duration:0.7];
}

#pragma mark 显示错误信息

+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error" view:view duration:0.7];
}
+ (void)showError:(NSString *)error toView:(UIView *)view duration:(CGFloat)duration {
    
    [self show:error icon:@"error" view:view duration:duration];

}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success" view:view duration:0.7];
}
+ (void)showSuccess:(NSString *)success toView:(UIView *)view  duration:(CGFloat)duration {
    [self show:success icon:@"success" view:view duration:duration];

}
#pragma mark 显示一些信息

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {

    return [self showMessag:message toView:view duration:0.7];
}
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view duration:(CGFloat)duration {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:duration > 0 ? duration:0.7];
    return hud;
}


@end
