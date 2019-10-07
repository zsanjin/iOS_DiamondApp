//
//  LoginVC.h
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/9.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppBaseViewController.h"

@interface LoginVC : AppBaseViewController

/** 登录成功回调*/
@property (nonatomic, copy) void(^loginSucceedBlock)(void);

@end
