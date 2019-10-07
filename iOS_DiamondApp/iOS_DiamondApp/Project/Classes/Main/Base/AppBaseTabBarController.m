//
//  AppBseeTabBarController.m
//  App_General_Template
//
//  Created by JXH on 2017/6/27.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "AppBaseTabBarController.h"
#import "AppBaseViewController.h"
#import "AppBaseNavigationController.h"



@interface AppBaseTabBarController ()

@end

@implementation AppBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //配置TabBar
    [self configDefaultTabBar];
}
- (void)configDefaultTabBar {
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    //选择颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    //默认颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewControllerWithInfoArray:(NSArray<NSDictionary *> *)items {
    
    if (!items.count) return;
    
    NSMutableArray * tabbarItems = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *item in items) {
    
        //没有写类，直接返回
        if (![item[kClassName] length]) continue;

        //基本类生成
        APPVCType type = [item[kVCType] integerValue];
        AppBaseViewController *vc = nil;
        
        if (type == APPVCType_Default) {
            vc = [[NSClassFromString(item[kClassName]) alloc] init];
        } else if (type == APPVCType_XIB) {
            vc = [[NSClassFromString(item[kClassName]) alloc]initWithNibName:item[kClassName] bundle:nil];
        }
        //配置导航
        UINavigationController *nav = [self addNavigation:vc withTitle:item[kTabbarTitle] imgName:item[kTabbarImage] selImageName:item[kTabbarSelectImage]];
        [tabbarItems addObject:nav];
    }
    
    if (tabbarItems.count) [self setViewControllers:tabbarItems];
    
//    self.viewControllers = tabbarItems;

}
- (UINavigationController *)addNavigation:(UIViewController *)vc withTitle:(NSString *)title imgName:(NSString *)imageName selImageName:(NSString *)selImageName{
    AppBaseNavigationController *nav = [[AppBaseNavigationController alloc] initWithRootViewController:vc];

    UIImage *img = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *sImg = [[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:title image:img selectedImage:sImg];
    nav.tabBarItem = barItem;
    vc.navigationItem.title = title;
    
    return nav;
    
}

NSString *const kClassName = @"className";
NSString *const kTabbarImage = @"itemImage";
NSString *const kTabbarSelectImage = @"itemSelectImage";
NSString *const kTabbarTitle = @"itemTitle";
NSString *const kVCType = @"vctype";

@end

