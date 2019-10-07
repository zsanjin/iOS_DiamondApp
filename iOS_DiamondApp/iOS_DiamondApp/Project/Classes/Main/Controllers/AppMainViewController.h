//
//  AppMainViewController.h
//  App_General_Template
//
//  Created by JXH on 2017/6/27.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppBaseTabBarController.h"
/** 主控制器，首次引导结束后将进入此控制器：可进行预加载配置以及广告等*/
@interface AppMainViewController : UIViewController

/** TabBarController*/
@property (nonatomic,strong,readonly) AppBaseTabBarController *tabBarController;


@end
