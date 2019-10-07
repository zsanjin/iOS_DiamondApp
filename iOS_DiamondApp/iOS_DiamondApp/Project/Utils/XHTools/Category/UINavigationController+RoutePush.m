//
//  UINavigationController+RoutePush.m
//  App_General_Template
//
//  Created by JXH on 2017/7/11.
//  Copyright © 2017年 JXH. All rights reserved.
//
#import "UINavigationController+RoutePush.h"
#import "AppBaseViewController.h"
#import "AppBaseCustomSystemTableViewController.h"

@implementation UINavigationController (RoutePush)
/**
 *  跳转
 *
 *  @param routeUrl 类型  vcname?a=b&c=d
 *  @param params 字典
 */
- (void)routePushViewController:(NSString *)routeUrl withParams:(NSDictionary *)params animated:(BOOL)animated {
    NSDictionary *route = [self parseRoute:routeUrl];
    NSMutableDictionary *newParams = route[@"params"];
    [newParams addEntriesFromDictionary:params];
    NSString *className = route[@"name"];
    
    AppBaseViewController * vc = nil;
    APPVCType type = [newParams[kVCType] integerValue];
    if (type == APPVCType_Default) {
        vc = [[NSClassFromString(className) alloc] init];
    } else if (type == APPVCType_XIB) {
        vc = [[NSClassFromString(className) alloc]initWithName:className];
    } else if (type == APPVCType_StoryBoard) {
        vc = [[UIStoryboard storyboardWithName:kStoryBoardName bundle:nil] instantiateViewControllerWithIdentifier:className];
    }
    
    //配置
    vc.navigationItem.title = newParams[kTitle];

    if ([vc isKindOfClass:[AppBaseViewController class]]) {
        
        vc.params = newParams;
        [vc updateParams];
        
    }else if ([vc isKindOfClass:[AppBaseCustomSystemTableViewController class]]) {
        
        vc.params = newParams;
        [vc updateParams];
    }

    vc.hidesBottomBarWhenPushed = YES;
    if (vc == nil) {
        NSLog(@"VC 为空。。。");
    }
    
    NSLog(@"是否主线程===%d",[NSThread isMainThread]);
    [self pushViewController:vc animated:YES];
}

/**
 *  解析路径
 *
 *  @param routeUrl 传入url
 *
 *  @return {name:"",params:{}}
 */
- (NSDictionary *)parseRoute:(NSString *)routeUrl{
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSArray * routes = [routeUrl componentsSeparatedByString:@"?"];
    if (routes.count == 2) {
        for (NSString *param in [[routes lastObject] componentsSeparatedByString:@"&"]) {
            NSArray *params = [param componentsSeparatedByString:@"="];
            [dic setObject:[params lastObject] forKey:[params firstObject]];
        }
    }
    return @{@"name":[routes firstObject],@"params":dic};
}

//static NSString *const kVCType = @"vctype";// controller 类型，是Xib，还是Class，默认不传为class
NSString *const kStoryBoardName = @"storyboardname";
//static NSString *const kXibName = @"xibname";
//static NSString *const kClassName = @"className";

@end


