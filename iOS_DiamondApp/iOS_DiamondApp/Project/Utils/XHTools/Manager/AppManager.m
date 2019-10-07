//
//  AppManager.m
//  Test_TouchId
//
//  Created by MrYeL on 2018/5/28.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "AppManager.h"

static AppManager *shareManager = nil;

@implementation AppManager

+ (instancetype)instance {
    
    if (shareManager) {
        return shareManager;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [AppManager new];
        shareManager.userLoginInfo = [AppUserInfoModel new];
        [shareManager prepare];

    });

    return shareManager;
}
- (void)prepare {
    //登录信息
    NSDictionary *dict =  [[NSUserDefaults standardUserDefaults] objectForKey:userLoginInfoKey];
    self.userLoginInfo = [AppUserInfoModel modelWithJSON:dict];

    //广告信息
    NSDictionary *adDict =  [[NSUserDefaults standardUserDefaults] objectForKey:AppAdInfoKey];
    self.adInfo = [XHAdInfoModel modelWithJSON:adDict];
    
    /** 版本信息 */
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * savedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:AppVersionKey];
    self.version = version;
    if (![savedVersion isEqualToString:version]) {
        
        self.firstLaunch = YES;
    }
    //启动设置
    self.needUpdateVersion = YES;
    //请求广告数据 进行保存更新
    [self transAdInfo];
    
}
#pragma mark - Setter and Getter
- (void)setFirstLaunch:(BOOL)firstLaunch {
    
    _firstLaunch = firstLaunch;
    
    if (firstLaunch) {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.version forKey:AppVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (void)saveUserLoginInfo {
    
    NSDictionary *dict = [self.userLoginInfo modelToJSONObject];//YYKIT
    
    if (dict.count) {
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:userLoginInfoKey];
        
    }else {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:userLoginInfoKey];
        
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void)saveAdInfo {
    
    NSDictionary *dict = [self.adInfo modelToJSONObject];//YYKIT
    if (dict.count) {
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:AppAdInfoKey];
        
    }else {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:AppAdInfoKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - NetWork
- (void)transAdInfo {
    
//    NSMutableDictionary *params = [NSMutableDictionary new];
//    [params setObject:@"1" forKey:@"adType"];
//    [YHHttpTool postWithUrl:Route_iGetADList withDic:params withBlock:^(NSMutableDictionary *requestParams, id result, NSError *error) {
    
//        if (isSucceedRequest) {
//            self.adInfo = [XHAdInfoModel modelWithJSON:result[@"body"]];
//            [self saveAdInfo];
//        }

//    }];
}
@end
