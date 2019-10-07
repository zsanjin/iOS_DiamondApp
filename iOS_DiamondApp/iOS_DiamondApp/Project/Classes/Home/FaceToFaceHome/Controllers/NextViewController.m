//
//  NextViewController.m
//  iOS_DiamondApp
//
//  Created by 蒋祥鸿 on 2019/2/22.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registCellWithNibArray:@[@"XHCarContactTableViewCell"]];

    //0.配置视图
    __weak typeof (self) weakSelf = self;

    [self addRefreshWithFoot:^{


        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf stopRefreshData];
            
            [weakSelf.viewModel addData:@"4"];
            [weakSelf.tableView reloadData];
        });
    
        
    }];
    [self addRefreshWithHead:^{
        
        [weakSelf stopRefreshData];
        
        [weakSelf.viewModel removeAllData];
        
        [weakSelf.viewModel addDatasFromArray:@[@"0",@"1",@"2",@"3"] atSection:0];

        [weakSelf.tableView reloadData];

    }];
    

    //1.请求数据
    [self.viewModel addDatasFromArray:@[@"0",@"1",@"2",@"3"] atSection:0];

}
- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"XHCarContactTableViewCell";
}
- (void)transData {
    
    
}

- (void)cell:(AppBaseTableViewCell *)cell InteractionEvent:(id)clickInfo {
    
    
}


@end
