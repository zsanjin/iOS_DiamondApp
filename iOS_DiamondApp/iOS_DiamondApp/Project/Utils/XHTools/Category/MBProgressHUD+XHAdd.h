//
//  MBProgressHUD+XHAdd.h
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/14.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

#define DefaultDurationForHUD 0.5
#define ShowMessage(message) [MBProgressHUD showMessag:message toView:nil duration:DefaultDurationForHUD];
#define showErrorMessage(msg) [MBProgressHUD showError:msg toView:nil];


@interface MBProgressHUD (XHAdd)

+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view duration:(CGFloat)duration;


+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view duration:(CGFloat)duration;


+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view duration:(CGFloat)duration;

@end
