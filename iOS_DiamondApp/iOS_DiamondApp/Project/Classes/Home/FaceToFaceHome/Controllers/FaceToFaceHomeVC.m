//
//  FaceToFaceHomeVC.m
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/21.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "FaceToFaceHomeVC.h"

#import "MultipleFunctionView.h"

#define SearchView_Height 60

//extension
@interface FaceToFaceHomeVC ()

/** fun*/
@property (nonatomic, strong) MultipleFunctionView * funtionView;

@end

@implementation FaceToFaceHomeVC

#pragma mark - System Method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self transData];
}
#pragma mark - Cunstom Method
- (void)configSubViews {//配置视图
    
    NSString *res = nil;
    NSArray *dataArray = @[@"1",@"2",@"3"];
    //
    res = [dataArray objectAtIndex:0];
    //
//    res = [dataArray objectAtIndex:3];
    //
//    res = [dataArray objectAtIndex:6];
    //
    res = [dataArray safeObjectAtIndex:3];
    [res isEqualToString:@"2"];
    //分类相当于在原有类的基础上增加方法，可以用原有类来调用
    res = [dataArray safeObjectAtIndex:6];
 
    //0.Search
    [self addSearchView];
    
    //1.Funtion
    [self addFuntionView];
    
    //2.TableView
    [self configTableView];
    
}
- (void)addSearchView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, SearchView_Height)];
    view.backgroundColor = [UIColor yellowColor];
    
    //背景
    UIView *bgView = [XHTools xh_getUIViewWithFrame:CGRectMake(10, 10, kScreenWidth - 100, 40) withBackgroundColor:UIColorHexStr(@"#EEEEED")];
    [view addSubview:bgView];

    //查询
    UILabel *tipLabel = [XHTools xh_getUILabelWithFrame:CGRectMake(10, 10, 70, 40) text:@"查询:" textColor:[UIColor t1] font:15 textAligment:NSTextAlignmentCenter];
    [view addSubview:tipLabel];
    
    //输入框
    UITextField *inputTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, kScreenWidth - 180, 40)];
    inputTF.placeholder = @"姓名/手机/城市/到店确认";
    [view addSubview:inputTF];
    
    //搜索按钮
    UIButton * searchBtn = [XHTools xh_getUIButtonWithFrame:CGRectMake(view.width - 80, 10, 70, 40) withTitle:@"检索" withFont:17 withTarge:self withSel:@selector(searchAction)];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor blueColor]];

    [view addSubview:searchBtn];
    [self.view addSubview:view];
    
}
- (void)addFuntionView {
    
    NSArray *funNameArray = @[@"待现场",@"半预约",@"全预约",@"跟进中",@"收藏",@"创建订单",@"正常",@"申关中",@"关闭",@"已放款",@"重置",@"致电后台"];
    self.funtionView = [MultipleFunctionView funtionViewWithFuntionNameArray:funNameArray];
    self.funtionView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + SearchView_Height, kScreenWidth, self.funtionView.totalHeight);
    [self.view addSubview:self.funtionView];
    
    self.funtionView.selectFunctionBlock = ^(MultipleFunctionView * _Nonnull view, NSString * _Nonnull funtionName, NSInteger index) {
       
        ShowMessage(funtionName);
    };
    
}
- (void)configTableView {
    
    //添加TableView
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.funtionView.frame), kScreenWidth, kScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT - SearchView_Height - self.funtionView.totalHeight);
    //注册Cell
    [self.tableView registCellWithNibArray:@[@"FaceToFaceHomeXibCell",@"XHCarContactTableViewCell"]];
    [self.tableView registCellWithClassArray:@[@"FaceToFaceHomeCell"]];
    
    __weak typeof(self) weakSelf = self;

    //添加刷新头
    [self addRefreshWithHead:^{
        [weakSelf.viewModel removeAllData];
        [weakSelf transData];
    }];
    //添加刷新尾
    [self addRefreshWithFoot:^{
        
        [weakSelf loadMoreData];

    }];
}
#pragma mark - delegate
- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row % 3) {
        case 0:
            return @"XHCarContactTableViewCell";
            break;
        case 1:
            return @"FaceToFaceHomeCell";
            break;
        default:
            return @"FaceToFaceHomeXibCell";
            break;
    }
    
}
#pragma mark - TableViewDataSource and TableViewDelegate
/** 对应位置返回Cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppBaseTableViewCell *cell = (AppBaseTableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
  
    return cell;
    
}
/**TableView的Item点击事件*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController routePushViewController:@"BannerViewController" withParams:@{kTitle:@"轮播图"} animated:YES];
    
  

}
/** 组头*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
/** 组尾*/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
 
    return nil;
}
#pragma mark - NetWork
- (void)transData {//请求数据
    
    [self stopRefreshData];
    [self.viewModel addDatasFromArray:@[@"数据0",@"数据1",@"数据2",@"数据3",@"数据4",@"数据5"] atSection:0];
    [self.tableView reloadData];

    
}
- (void)loadMoreData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self stopRefreshData];
        [self.viewModel addData:@"添加尾部数据"];
        [self.tableView reloadData];
    });
    
}
#pragma mark - Action
- (void)searchAction {
    
    ShowMessage(@"搜索");

}
- (void)cell:(AppBaseTableViewCell *)cell InteractionEvent:(id)clickInfo {
    
    NSIndexPath *indexPath = cell.indexPath;
    
}
/** 父类代理*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}
@end
