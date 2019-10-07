//
//  UINavigationController+RoutePush.h
//  App_General_Template
//
//  Created by JXH on 2017/7/11.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

/** title*/
static NSString *const kTitle = @"title";
/** block*/
static NSString *const kBlock = @"block";

@interface UINavigationController (RoutePush)

/**
 *  跳转
 *
 *  @param routeUrl 类型  vcname?a=b&c=d
 *  @param params 字典
 */
- (void)routePushViewController:(NSString *)routeUrl withParams:(NSDictionary *)params animated:(BOOL)animated;

@end
