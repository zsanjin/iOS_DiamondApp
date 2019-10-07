//
//  AppBaseNavigationController.m
//  App_General_Template
//
//  Created by JXH on 2017/6/27.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "AppBaseNavigationController.h"

@interface AppBaseNavigationController ()

@end

@implementation AppBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    //可以添加换肤监听
    
    //默认初始化
    [self configDefaultNavigationBar];
    
}

- (void)configDefaultNavigationBar {
    
    NSDictionary *dict = @{NSFontAttributeName :  Font(16),
                           NSForegroundColorAttributeName : UIColorHexStr(@"0x111111")};
    self.navigationBar.titleTextAttributes = dict;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
