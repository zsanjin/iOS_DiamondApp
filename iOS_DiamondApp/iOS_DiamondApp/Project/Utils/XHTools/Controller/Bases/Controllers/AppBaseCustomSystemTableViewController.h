//
//  AppBaseCustomSystemTableViewController.h
//  CangoToB
//
//  Created by MrYeL on 2018/4/9.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppBaseTableViewCell.h"//Cell
#import "AppBaseTableViewDataModel.h"//Data


//Refresh
typedef void(^reload)(void);
typedef void(^loadMore)(void);

@interface AppBaseCustomSystemTableViewController : UITableViewController

#pragma mark - Base
/** 上一级过来传的参数：用于新界面的使用*/
@property (nonatomic, copy) NSDictionary *params;
/** ViewModel*/
@property (nonatomic,strong) AppBaseTableViewDataModel *viewModel;
/** 请求数据*/
- (void)transData;
/** 更新参数*/
- (void)updateParams;
/** 更新子视图*/
- (void)configSubViews;
/** 返回*/
- (void)pop;

/**  返回cell重用标识符：如果有自己注册cell，子类必须重写才能正确返回*/
- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 刷新相关
-(void)addRefreshWithHead:(reload)head;
-(void)addRefreshWithFoot:(loadMore)foot;
/** 停止刷新*/
- (void)stopRefreshData;
/** 停止刷新且无更多数据*/
- (void)stopRefreshWithNoMoreData;
/** 重置刷新*/
- (void)resetRefresh;
@end
