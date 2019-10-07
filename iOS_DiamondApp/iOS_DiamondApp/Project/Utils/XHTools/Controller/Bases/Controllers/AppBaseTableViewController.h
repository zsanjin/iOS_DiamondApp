//
//  AppBaseTableViewController.h
//  App_General_Template
//
//  Created by JXH on 2017/7/13.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "AppBaseViewController.h"
#import "AppBaseTableView.h"//TableView
#import "AppBaseTableViewCell.h"//Cell
#import "AppBaseTableViewDataModel.h"//Data


//Refresh
typedef void(^reload)(void);
typedef void(^loadMore)(void);

@interface AppBaseTableViewController : AppBaseViewController<UITableViewDelegate,UITableViewDataSource,AppBaseTableViewCellDelegate>

/** TableView：只读只能更改属性，不能重新给定TableView*/
@property (nonatomic, strong, readonly) AppBaseTableView *tableView;

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
