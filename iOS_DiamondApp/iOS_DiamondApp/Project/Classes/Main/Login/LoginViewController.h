//
//  LoginViewController.h
//  iOS_Learning_Demo
//
//  Created by zhangsheng on 2019/1/16.
//  Copyright © 2019年 MrYeL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

/** 登录成功回调*/
@property (nonatomic, copy) void(^loginSucceedBlock)(void);

@property (nonatomic,weak) UITextField *mobileTextFiled;

@end

NS_ASSUME_NONNULL_END
