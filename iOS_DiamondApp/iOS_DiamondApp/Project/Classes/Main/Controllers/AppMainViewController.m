//
//  AppMainViewController.m
//  App_General_Template
//
//  Created by JXH on 2017/6/27.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "AppMainViewController.h"

@interface AppMainViewController ()


@end

@implementation AppMainViewController

@synthesize tabBarController = _tabBarController;

#pragma mark - Lazy load
- (AppBaseTabBarController *)tabBarController {
    
    if (_tabBarController == nil) {
        _tabBarController = [[AppBaseTabBarController alloc] init];
    }
    return _tabBarController;
    
}
#pragma mark - System Method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    //初始化Tabbar
    [self configSubViews];
    
    //初始化配置和广告：在初始化结束后将显示TabBarVC
//    [self preloadAdAndConfig];
    
    [self showHome];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Method
- (void)configSubViews {//
    
    //添加控制器
    [self.tabBarController addChildViewControllerWithInfoArray:@[@{kClassName:@"HomeViewController",kTabbarTitle:@"首页",kTabbarImage:@"",kTabbarSelectImage:@""}]];

}
/** 初始化服务器配置和广告：在初始化结束后将显示TabBarVC*/
- (void)preloadAdAndConfig {
    
//    self.view.backgroundColor = [UIColor redColor];
    self.view.alpha = 0;

    [UIView animateWithDuration:0 animations:^{
        
        self.view.alpha = 1;

    } completion:^(BOOL finished) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        [self showHome];
    }];
    
    
}
- (void)showHome {
    //保存底部控制
    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
}


@end
