//
//  LoginVC.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/9.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "LoginVC.h"
#import "TouchID.h"

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configSubViews];
}

- (void)configSubViews {
    
     UIButton *passwordLogin = [XHTools xh_getUIButtonWithFrame:CGRectMake(kScreenWidth *0.5- 50, NAVIGATION_BAR_HEIGHT + 15, 100, 40) withTitle:@"账户密码登录" withFont:15 withTarge:self withSel:@selector(loginWithPassword:)];
    passwordLogin.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:passwordLogin];
    
    UIButton *touchIdLogin = [XHTools xh_getUIButtonWithFrame:CGRectMake(kScreenWidth *0.5 - 50, NAVIGATION_BAR_HEIGHT + 15 + 100 + 15, 100, 40) withTitle:@"TouchID登录" withFont:15 withTarge:self withSel:@selector(loginWithTouchId:)];
    [self.view addSubview:touchIdLogin];
    touchIdLogin.backgroundColor = [UIColor cyanColor];
    
    XHBorderRadius(touchIdLogin, 5, 0, [UIColor whiteColor]);
    XHBorderRadius(passwordLogin, 5, 0, [UIColor whiteColor]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginWithPassword:(UIButton *)sender {
    
    [sender addActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [sender removeActivityIndicatorWithTitle:@"账户密码登录"];

        [weakSelf loginSucceed];
        
        if (weakSelf.loginSucceedBlock) {
            weakSelf.loginSucceedBlock();
        }

    });
    
}
- (void)loginSucceed {
    
    if (![AppManager instance].userLoginInfo) {
        [AppManager instance].userLoginInfo = [AppUserInfoModel new];
    }
    [AppManager instance].userLoginInfo.userId = @"123";
    [[AppManager instance] saveUserLoginInfo];

}
- (void)loginWithTouchId:(UIButton *)sender {
    
    [sender addActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];
    __weak typeof(self) weakSelf = self;

    [[TouchID shareInstance] showTouchIdWithDesc:nil andStateBlock:^(TBTouchIDState state, NSError *error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender removeActivityIndicatorWithTitle:@"TouchID登录"];

            if (state == TBTouchIDStateSuccess) {
                if (weakSelf.loginSucceedBlock) {
                    weakSelf.loginSucceedBlock();
                }
                [weakSelf loginSucceed];

            }else {
                
            }
            
        });
    }];
    
    
}

- (void)dealloc {
    NSLog(@"%@: dealloced \n",NSStringFromClass(self.class));
    
}

@end
