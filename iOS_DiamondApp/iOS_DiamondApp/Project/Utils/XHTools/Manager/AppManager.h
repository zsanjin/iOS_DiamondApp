//
//  AppManager.h
//  Test_TouchId
//
//  Created by MrYeL on 2018/5/28.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XHAdInfoModel.h"
#import "AppUserInfoModel.h"

static  NSString *const AppVersionKey = @"appVersion";
static  NSString *const userLoginInfoKey = @"userLoginInfo";
static  NSString *const AppAdInfoKey = @"appAdInfoKey";

#define GetUser_Id ([AppManager instance].userLoginInfo.userId.length?[AppManager instance].userLoginInfo.userId:@"")


@interface AppManager : NSObject
@property (nonatomic, strong) AppUserInfoModel *userLoginInfo;//用户登录信息
@property (nonatomic, strong) XHAdInfoModel *adInfo;//广告信息
@property (nonatomic, assign) BOOL tapAd;/** 记录点击了广告*/
@property (nonatomic, copy) NSString *version;//版本信息1.0
@property (nonatomic, assign) BOOL firstLaunch;//首次启动
@property (nonatomic, assign) BOOL needUpdateVersion;//需要检测更新


+ (instancetype)instance;

- (void)prepare;//启动初始化数据
- (void)saveUserLoginInfo;//保存或移除登录信息
- (void)saveAdInfo;//保存或移除广告数据

@end
