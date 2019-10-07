//
//  TouchID.m
//  Test_TouchId
//
//  Created by MrYeL on 2018/5/29.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "TouchID.h"
#import <LocalAuthentication/LocalAuthentication.h>

static TouchID *instance = nil;

@implementation TouchID

+ (instancetype)shareInstance {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      
        instance = [TouchID new];
    });
    
    return instance;
    
}
/** 显示TouchId的描述与回调*/

- (void)showTouchIdWithDesc:(NSString *)desc andStateBlock:(touchIDStateBlock)block {
    
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"系统版本不支持TouchID (必须高于iOS 8.0才能使用)");
            ShowMessage(@"系统版本不支持TouchID (必须高于iOS 8.0才能使用)");
            block(TBTouchIDStateVersionNotSupport,nil);
        });
        
        return;
    }
    
    
    LAContext *context = [[LAContext alloc] init];

    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:desc == nil ? @"通过Home键验证已有指纹":desc reply:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 验证成功");
                block(TBTouchIDStateSuccess,error);
            });
        }else if(error){
            
            switch (error.code) {
                case LAErrorAuthenticationFailed:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 验证失败");
                        block(TBTouchIDStateFail,error);
                    });
                    break;
                }
                case LAErrorUserCancel:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 被用户手动取消");
                        block(TBTouchIDStateUserCancel,error);
                    });
                }
                    break;
                case LAErrorUserFallback:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"用户不使用TouchID,选择手动输入密码");
                        block(TBTouchIDStateInputPassword,error);
                    });
                }
                    break;
                case LAErrorSystemCancel:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                        block(TBTouchIDStateSystemCancel,error);
                    });
                }
                    break;
                case LAErrorPasscodeNotSet:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 无法启动,因为用户没有设置密码");
//                        [TBProgressHUD showErrorWithtitle:@"您的设备未设置密码"];
                        ShowMessage(@"TouchID 无法启动,您的设备未设置密码");
                        block(TBTouchIDStatePasswordNotSet,error);
                    });
                }
                    break;
                case LAErrorTouchIDNotEnrolled:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
//                        [TBProgressHUD showErrorWithtitle:@"您的设备未录入指纹"];
                        ShowMessage(@"您的设备未录入指纹");

                        block(TBTouchIDStateTouchIDNotSet,error);
                    });
                }
                    break;
                case LAErrorTouchIDNotAvailable:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 无效");
                        ShowMessage(@"TouchID 无效");

                        block(TBTouchIDStateTouchIDNotAvailable,error);
                    });
                }
                    break;
                case LAErrorTouchIDLockout:{//iOS 9.0之后才有
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                        ShowMessage(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");

                        if (@available(iOS 9.0, *)) {
                         LAContext * touchId = [LAContext new];
                            [touchId evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请输入开机密码以解锁Touch ID" reply:^(BOOL success, NSError * _Nullable error) {
                                if (success) {
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                    block(TBTouchIDStateSuccess,error);
                                    });
                                }
                            }];
                        } else {
                            // Fallback on earlier versions
                            NSLog(@"验证失败");
                            block(TBTouchIDStateTouchIDLockout,error);

                        }
                    });
        
                }
                    break;
                case LAErrorAppCancel:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                        block(TBTouchIDStateAppCancel,error);
                    });
                }
                    break;
                case LAErrorInvalidContext:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                        block(TBTouchIDStateInvalidContext,error);
                    });
                }
                    break;
                default:
                    break;
            }
        }
    }];
    
}


@end
