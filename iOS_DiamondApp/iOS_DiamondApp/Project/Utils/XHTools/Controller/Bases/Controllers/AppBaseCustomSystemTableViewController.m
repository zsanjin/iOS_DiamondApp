//
//  AppBaseCustomSystemTableViewController.m
//  CangoToB
//
//  Created by MrYeL on 2018/4/9.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import "AppBaseCustomSystemTableViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "UITableView+Custom.h"
#import "Reachability.h"


@interface AppBaseCustomSystemTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,AppBaseTableViewCellDelegate>

@end

@implementation AppBaseCustomSystemTableViewController
#pragma mark - Lazy Load： 懒加载
/** 基本VC数据管理模型类*/
- (AppBaseTableViewDataModel *)viewModel {
    
    if (_viewModel == nil) {
        _viewModel = [[AppBaseTableViewDataModel alloc] init];

    }
    return _viewModel;
}
//解析上一级传进来的参数，子类有需要重写实现即可
- (void)updateParams {
    //子类实现，解析字典参数
    self.navigationItem.title = self.params[kTitle];
}
#pragma mark - System Method：系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //解析参数
    [self updateParams];
    /** 配置基本TableView*/
    [self baseTableViewControllerConfigTableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Method：自定义方法
- (void)baseTableViewControllerConfigTableView {
    /** 有导航的默认自己重新给Frame*/
//    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight - TOP_Y);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //空数据
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    /** 添加默认的Footer和Header,可防止多余高度带分割线问题*/
    self.tableView.tableFooterView = [self tableViewFooterView];
    self.tableView.tableHeaderView = [self tableViewHeaderView];
    
    /** 注册Cell*/
    [self.tableView registCellWithClassArray:@[@"AppBaseTableViewCell"]];
    

}
/** 返回cell重用标识符：子类重写 */
- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath {
    /** 通过类名返回，可防止出错*/
    return NSStringFromClass([AppBaseTableViewCell class]);
}
#pragma mark - TableView DataSource：代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger count = self.viewModel.allDataDic.count;
    
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr = [self.viewModel.allDataDic objectForKey:@(section)];
    
    if ([arr isKindOfClass:[NSArray class]]) {
        return [arr count];
    } else {
        return 0;
    }
}
/**
 获取cell
 根据代理方法获取本indexpath的cell的identitify，再获取注册好的cell，
 本方法设置了cell的tag，以做一些需要自定义的工作。
 cell的点击事件等其他的一些事件，可以通过代理方法- (void)cell:(SKBaseTableViewCell *)cell InteractionEvent:(id)clickInfo；来处理，
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /** 获取Id*/
    NSString *identify = [self cellIdentifyAtIndexPath:indexPath];
    /** 获取Cell*/
    AppBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    /** 配置Cell*/
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.section*10000 + indexPath.row;
    cell.indexPath = indexPath;
    cell.delegate = self;
    NSArray *sectionData = [self.viewModel.allDataDic objectForKey:@(indexPath.section)];
    
    /** 赋值Cell*/
    if ([sectionData isKindOfClass:[NSArray class]]&&sectionData.count>indexPath.row) {
        [cell configData:sectionData[indexPath.row]];
    }
    return cell;
}
#pragma mark - TableView Delegate：代理
//cell高度，子类重写吧
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.tableView.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
#pragma mark - AppBaseTableViewDelegate：刷新代理
-(void)addRefreshWithHead:(reload)head{
    
    //    self.tableView.mj_header = [TBProgressView headerWithRefreshingBlock:^{
    //        head();
    //    }];
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        head();
        
    }];
}
-(void)addRefreshWithFoot:(loadMore)foot{
    MJRefreshAutoNormalFooter *autoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        foot();
    }];
    [autoNormalFooter setTitle:@"" forState:MJRefreshStateIdle];
    self.tableView.mj_footer = autoNormalFooter;// [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    //    }];
}
#pragma mark - AppBaseTableViewCell Delegate: cell事件回调
- (void)cell:(AppBaseTableViewCell *)cell InteractionEvent:(id)clickInfo {
    
}
#pragma mark - Config BaseTableView：配置基本的TableView
/** 组尾：子类可重写*/
- (UIView *)tableViewFooterView {
    return [[UIView alloc]init];
}
/** 组头：子类可重写*/
- (UIView *)tableViewHeaderView {
    return [[UIView alloc]init];
}
#pragma mark - 刷新相关
/** 停止刷新*/
- (void)stopRefreshData {
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}
/** 停止刷新且无更多数据*/
- (void)stopRefreshWithNoMoreData {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
/** 重置刷新*/
- (void)resetRefresh {
    [self.tableView.mj_footer resetNoMoreData];
}
#pragma mark tableview无数据时候
//空数据图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"no_business"];
}
//空数据标题说明
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = [[Reachability reachabilityForInternetConnection] isReachable] == 0?@"网络不给力哦~":@"暂无数据";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:15.0]
                   range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor lightGrayColor]
                   range:NSMakeRange(0, text.length)];
    return attStr;
}
//空数据按钮文字说明
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *text = @"请点击重试哦~";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:15.0]
                   range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor whiteColor]
                   range:NSMakeRange(0, text.length)];
    
    return nil;
}
//空数据按钮背景图片
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    UIImage *image = [UIImage imageNamed:@"no_business"];
    UIEdgeInsets capInsets = UIEdgeInsetsMake(22.0, 22.0, 22.0, 22.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsMake(0.0, -50, 0.0, -50);
    return nil;//[[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}
//空数据按钮点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // button clicked...
    [self.tableView.mj_header beginRefreshing];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    CGFloat offset = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    offset += CGRectGetHeight(self.navigationController.navigationBar.frame);
    return -offset;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
#pragma mark - Custom Method
- (void)configSubViews {
    
}
/** 请求数据*/
- (void)transData {
    
    
}
//监听子类释放
- (void)dealloc {
    
    NSLog(@"-[%@ dealloc]\n\n\n\n\n\n\n\n\n\n\n\n",NSStringFromClass([self class]));
}
- (void)pop {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
