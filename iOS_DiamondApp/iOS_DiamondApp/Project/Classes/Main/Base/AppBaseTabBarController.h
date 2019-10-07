//
//  AppBseeTabBarController.h
//  App_General_Template
//
//  Created by JXH on 2017/6/27.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 基本TabBar控制器*/
@interface AppBaseTabBarController : UITabBarController

- (void)addChildViewControllerWithInfoArray:(NSArray<NSDictionary *> *)items;

@end
