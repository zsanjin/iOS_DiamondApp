//
//  AppBaseViewController.m
//  App_General_Template
//
//  Created by JXH on 2017/7/6.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "AppBaseViewController.h"

@interface AppBaseViewController ()


@end

@implementation AppBaseViewController
#pragma mark - Lazy Load： 懒加载
/** 基本VC数据管理模型类*/
- (AppBaseTableViewDataModel *)viewModel {
    
    if (_viewModel == nil) {
        _viewModel = [[AppBaseTableViewDataModel alloc] init];
    }
    return _viewModel;
}

//解析上一级传进来的参数，子类有需要重写实现即可
- (void)updateParams {
    //子类实现，解析字典参数
    self.navigationItem.title = self.params[kTitle];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //解析参数
    [self updateParams];

}
- (void)setParams:(NSDictionary *)params {
    
    if (self.params.count) {
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:self.params];
        [mDic addEntriesFromDictionary:params];
        _params = mDic;
    }else{
        _params = params;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Method
- (void)configSubViews {
    
}
/** 请求数据*/
- (void)transData {

    
}
///** 设置导航*/
//- (void)viewWillAppear:(BOOL)animated {
//    
//    /** 关于导航的一些设置初始化*/
//    if (self.transparentNavigationBar) {
//        [self  setTranslucentNavigationBar];
//    } else {
//        [self defaultNavigationBar];
//    }
//    
//    [super viewWillAppear:animated];
//    
//}
///** 设置导航*/
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    if (self.transparentNavigationBar) {
//        
//        [self  setTranslucentNavigationBar];
//        
//    } else {
//        
//        [self defaultNavigationBar];
//    }
//}
///** 重置导航*/
//- (void)viewWillDisappear:(BOOL)animated {
//    /** 关于导航的一些设置初始化*/
//    if (self.transType) {//通过barView
//        self.navigationBarView.alpha = 1;
//        for (UIView *effect in self.navigationBarView.subviews) {
//            effect.hidden = NO;
//        }
//        self.navigationBarView = nil;
//    }else {//通过导航背景
//        [self defaultNavigationBar];
//    }
//    
//    [super viewWillDisappear:animated];
//    
//}
//- (void)setTranslucentNavigationBar {
//    
//    switch (self.transType) {
//        case NavigationTransType_BarView:
//        {
//            self.navigationController.navigationBar.translucent = YES;
//            self.navigationBarView = [self setupNavigationBarSubViews];
//            
//            break;
//        }
//        case NavigationTransType_Default_Img:{
//            
//            self.navigationController.navigationBar.translucent = YES;
//            self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
//            //    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
//            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
//            [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
//        }
//            break;
//        default:
//            break;
//    }
//    
//}
/** 设置默认导航*/
- (void)defaultNavigationBar {
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:UIColorHexStr(@"0xe1e1e1")]];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
}
/** 获取导航背景*/
- (UIView *)setupNavigationBarSubViews {
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([NSStringFromClass([view class])isEqualToString:@"_UIBarBackground"]) {
            view.backgroundColor = [UIColor colorWithRed:6 / 255.0 green:39/255.0 blue:63/255.0 alpha:0.7];
            view.alpha = 0;
            for (UIView *effect in view.subviews) {
                effect.hidden = YES;
            }
            return view;
        }
    }
    return nil;
}

//监听子类释放
- (void)dealloc {
    
    NSLog(@"-[%@ dealloc]\n\n\n\n\n\n\n\n\n\n\n\n",NSStringFromClass([self class]));
}

- (void)pop {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
