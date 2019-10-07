//
//  HomeViewController.m
//  iOS_Learning_Demo
//
//  Created by MrYeL on 2019/1/15.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "HomeViewController.h"

#import "Masonry.h"

#import "TableViewDemoViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"点击一下去使用";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:tipLabel];

    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
        make.centerX.centerY.mas_equalTo(self.view);
    }];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.navigationController pushViewController:[TableViewDemoViewController new] animated:YES];
    
}

+ (void)hello{
    
    
}


@end
