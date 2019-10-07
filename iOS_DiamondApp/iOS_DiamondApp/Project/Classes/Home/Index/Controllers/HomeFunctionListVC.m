//
//  HomeFunctionListVC.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/10.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "HomeFunctionListVC.h"
#import "LoginViewController.h"

typedef NS_ENUM(NSInteger,Function_Type){
    
    Function_Type_Login,//TouchId登录
    Function_Type_Home,//首页
    Function_Type_Voice,//语音识别
    Function_Type_F2F,//面销


    
};

@interface HomeFunctionListVC ()

@end

@implementation HomeFunctionListVC

#pragma mark - System Method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"功能列表";
    
    [self configData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Method
- (void)configData {
    
    
    NSArray *functionArray = @[
                               @{kTitle:@"--退出登录--",@"type":@(Function_Type_Login)},
                               @{kTitle:@"1.首页",kClassName:@"SurfaceListViewController",@"type":@(Function_Type_Home)},
                               @{kTitle:@"2.语音识别",kClassName:@"VoiceTestViewController",@"type":@(Function_Type_Voice)},
                               @{kTitle:@"3.金刚钻",kClassName:@"FaceToFaceHomeVC",@"type":@(Function_Type_F2F)},

                      
                               ];
    
    [self.viewModel addDatasFromArray:functionArray atSection:0];
    
}
#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *functionDic = [[self.viewModel.allDataDic objectForKey:@(indexPath.section)] safeObjectAtIndex:indexPath.row];
    Function_Type type = [functionDic[@"type"] integerValue];//type
    NSString *title = functionDic[kTitle]?functionDic[kTitle]:@"";//name
    NSString *vcName = functionDic[kClassName];//vcName
    
    switch (type) {
            //case 特殊处理
        case Function_Type_Login:
            [self loginStateChangeWithOut:YES];
            break;
            
            //default 推出新的控制器
        default:
        {
            if (vcName.length) {
                [self.navigationController routePushViewController:vcName withParams:@{kTitle:title} animated:YES];
            }
        }
            break;
    }
    
    
}
#pragma mark - Action
/** 退出登录*/
- (void)loginStateChangeWithOut:(BOOL)isOut {
    
    if (isOut) {
        AppManager.instance.userLoginInfo.userId = @"";
        [AppManager.instance saveUserLoginInfo];
    }

    LoginViewController *login = [LoginViewController new];
    
    __block LoginViewController *wsLogin = login;
    login.loginSucceedBlock = ^{
        
        [AppManager.instance saveUserLoginInfo];
        [wsLogin dismissViewControllerAnimated:YES completion:nil];
        wsLogin = nil;
        
    };
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}



@end
