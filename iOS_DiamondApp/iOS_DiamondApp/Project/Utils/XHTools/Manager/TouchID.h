//
//  TouchID.h
//  Test_TouchId
//
//  Created by MrYeL on 2018/5/29.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TouchID : NSObject

/**
 *  TouchID 状态
 */
typedef NS_ENUM(NSUInteger, TBTouchIDState){
    
    /**
     *  当前设备不支持TouchID
     */
    TBTouchIDStateNotSupport = 0,
    /**
     *  TouchID 验证成功
     */
    TBTouchIDStateSuccess = 1,
    
    /**
     *  TouchID 验证失败
     */
    TBTouchIDStateFail = 2,
    /**
     *  TouchID 被用户手动取消
     */
    TBTouchIDStateUserCancel = 3,
    /**
     *  用户不使用TouchID,选择手动输入密码
     */
    TBTouchIDStateInputPassword = 4,
    /**
     *  TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)
     */
    TBTouchIDStateSystemCancel = 5,
    /**
     *  TouchID 无法启动,因为用户没有设置密码
     */
    TBTouchIDStatePasswordNotSet = 6,
    /**
     *  TouchID 无法启动,因为用户没有设置TouchID
     */
    TBTouchIDStateTouchIDNotSet = 7,
    /**
     *  TouchID 无效
     */
    TBTouchIDStateTouchIDNotAvailable = 8,
    /**
     *  TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)
     */
    TBTouchIDStateTouchIDLockout = 9,
    /**
     *  当前软件被挂起并取消了授权 (如App进入了后台等)
     */
    TBTouchIDStateAppCancel = 10,
    /**
     *  当前软件被挂起并取消了授权 (LAContext对象无效)
     */
    TBTouchIDStateInvalidContext = 11,
    /**
     *  系统版本不支持TouchID (必须高于iOS 8.0才能使用)
     */
    TBTouchIDStateVersionNotSupport = 12
};

+ (instancetype)shareInstance;

typedef void(^touchIDStateBlock)(TBTouchIDState,NSError*);
/** 显示TouchId的描述与回调*/
- (void)showTouchIdWithDesc:(NSString *)desc andStateBlock:(touchIDStateBlock)block;

@end
