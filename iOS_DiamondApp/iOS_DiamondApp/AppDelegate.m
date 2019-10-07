//
//  AppDelegate.m
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/16.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "AppDelegate.h"

#import "ZWIntroductionViewController.h"
#import "XHAdViewController.h"
#import "LoginVC.h"
#import "LoginViewController.h"

#import "iflyMSC/IFlyMSC.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //启动配置
    [self configLaunch:launchOptions];
    
    return YES;
}
//初始化启动：需要进行的初始化操作都放入这个方法里，进行配置，每个方法，请封装成单独的方法
- (void)configLaunch:(NSDictionary *)launchOptions {
    
    //例如0.设置窗口
    [self configWindow];
    
    //例如1.配置三方
    dispatch_async(JGlobalQueue, ^{//防止启动阻塞线程
        //1.语音识别设置
        [self speechRecognizeServiceInit];
    });
    //例如2.其他操作
    
}
//设置窗口0
- (void)configWindow {
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //第一次启动：引导操作
    BOOL firstLaunch = [AppManager instance].firstLaunch;
    if (firstLaunch) {
        self.window.rootViewController = [self addGuideView];
        //第一次启动置为 NO！
        [AppManager instance].firstLaunch = NO;

    } else {//否则：正常启动
        [self launchWindow];
    }
    [self.window makeKeyAndVisible];
}
#pragma mark - 启动
- (void)launchWindow {

    if ([AppManager instance].userLoginInfo.userId.length) {//已登录

        [self setAdControlIsRootWithType:NO];//加载广告
    
    } else {//未登录，不出广告
        
        [self setLoginIsRoot];
    }
    
}
/** 设置广告为root*/
- (void)setAdControlIsRootWithType:(BOOL)isLogin {
    
    //是否是登录
    XHAdViewController *adVc = [[XHAdViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    adVc.adCompletedBlock = ^(BOOL complete) {
        if (isLogin) {
            [weakSelf setLoginIsRoot];//去登录
        }else {
            [weakSelf setTabBarIsRoot];//去主界面// 记录是否需要加载
        }
    };
    self.window.rootViewController = adVc;
    
}
/** 设置登录为root*/
- (void)setLoginIsRoot {
    __weak typeof(self) weakSelf = self;
    
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    loginVc.loginSucceedBlock = ^{
        
        [weakSelf setTabBarIsRoot];//去主界面// 记录是否需要加载
    };
    
//    LoginVC *loginVc = [[LoginVC alloc] init];
//    loginVc.loginSucceedBlock = ^{
//
//        [weakSelf launchWindow];
//    };
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVc];
    self.window.rootViewController = navi;
    
}
/** 设置main为root*/
- (void)setTabBarIsRoot {
//    Class mainClass = NSClassFromString(@"AppMainViewController");//带Tabbar
//    self.window.rootViewController = [[mainClass alloc] init];
    
    Class mainClass = NSClassFromString(@"HomeFunctionListVC");//不带Tabbar直接进入首页
    self.window.rootViewController =[[UINavigationController alloc] initWithRootViewController: [[mainClass alloc] init]];

}
#pragma mark - 引导图
- (ZWIntroductionViewController *)addGuideView
{
    // Added Introduction View Controller
    NSArray *backgroundImageNames = @[@"LaunchGuideImage_0"];
    NSArray *coverImageNames = @[@""];
    
    ZWIntroductionViewController *introductionVC = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
    
    __weak typeof(self) weakSelf = self;
    
    introductionVC.didSelectedEnter = ^() {
        
        [weakSelf launchWindow];//
    };
    
    return introductionVC;
}
#pragma mark - 语音识别初始化
- (void)speechRecognizeServiceInit{
    
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_NONE];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:NO];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",AppId_Voice];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
