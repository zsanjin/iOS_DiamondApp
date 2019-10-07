//
//  SurfaceListViewController.m
//  iOS_Learning_Demo
//
//  Created by zhangsheng on 2019/1/17.
//  Copyright © 2019年 MrYeL. All rights reserved.
//

#import "SurfaceListViewController.h"
#import "Masonry.h"
#import "SurfaceListTableViewCell.h"
#import "OrderInfo.h"

#define COL_COUNT 6
#define BUTTON_WIDTH 60
#define BUTTON_HEIGHT 20

@interface SurfaceListViewController ()<UITableViewDelegate,UITableViewDataSource>

/** DataList*/
@property (nonatomic, copy) NSArray * dataArray;
/** TableView*/
@property (nonatomic, strong) UITableView * tableView;

@end

//#define <#macro#>

@interface SurfaceListViewController ()

@end

@implementation SurfaceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.title = @"面销列表页面";
    
    UIView *headerView = [[UIView alloc]init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10+NAVIGATION_BAR_HEIGHT);
        make.right.mas_equalTo(self.view.mas_right).offset(-100);
        make.height.mas_equalTo(40);
    }];
    headerView.backgroundColor = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1.0];
    
    UILabel *mobileLabel = [[UILabel alloc] init];
    [headerView addSubview:mobileLabel];
    [mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.equalTo(headerView.mas_top).offset(5);
        make.centerY.mas_equalTo(headerView.mas_centerY);
        make.left.mas_equalTo(headerView.mas_left).offset(15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(headerView.mas_height);
       
    }];
    mobileLabel.text = @"查询";
    mobileLabel.textAlignment = NSTextAlignmentRight;
    
    UITextField *searchTextField = [[UITextField alloc]init];
    [headerView addSubview:searchTextField];
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView.mas_centerY);
        make.height.mas_equalTo(headerView.mas_height);
        make.left.mas_equalTo(mobileLabel.mas_right).offset(15);
        make.right.mas_equalTo(headerView.mas_right).offset(5);
    }];
    
    searchTextField.placeholder = @"姓名/手机/城市/到店确认码";
//    mobileLabel.verticalAlignment = NSText
    
    // UIbutton：声明、赋值样式
    UIButton *searchbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    // 将button 添加到view中
    [self.view addSubview:searchbutton];
    // 利用masonry惊醒约束布局
    [searchbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_right).offset(-95);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(headerView.mas_top);
        make.height.mas_equalTo(headerView.mas_height);
    }];
    
    // 增加一个层
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    //因为利用了Masonry.h，后面不能宽高。https://www.jianshu.com/p/4676d84458f7
    [searchbutton layoutIfNeeded];
    // 设置层的长宽高和控件一致
    gradientLayer.frame = searchbutton.bounds;
    gradientLayer.colors = @[
                             (id)[UIColor colorWithRed:66.0f/255.0f green:213.0f/255.0f blue:143.0f/255.0f alpha:1.0f].CGColor,
                             (id)[UIColor colorWithRed:38.0f/255.0f green:143.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor];
    //开始点
    gradientLayer.startPoint = CGPointMake(0, 0);
    //结束点
    gradientLayer.endPoint = CGPointMake(1, 1);
    //渐变点
    gradientLayer.locations = @[@(0.5),@(1.0)];
    // 增加到控件上
    [searchbutton.layer addSublayer:gradientLayer];
    // 设置空间标题和样式
    [searchbutton setTitle:@"检索" forState:UIControlStateNormal];

    [searchbutton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *buttons = @[@"待现场",@"半预约",@"全预约",@"跟进中",@"收藏",@"创建订单",@"正常",@"申关中",@"关闭",@"已放款",@"重置",@"致电后台"];
    
    UIView *secondView = [[UIView alloc]init];
    [self.view addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(headerView.mas_bottom).offset(10);
        make.right.mas_equalTo(searchbutton.mas_right);
        make.height.mas_equalTo(70);
    }];
    
    for(int i = 0 ;i<buttons.count ;i++){
        UIButton *uiButton = [[UIButton alloc] init];

        NSInteger row = i / COL_COUNT +1;
        NSInteger col = i % COL_COUNT;

        CGFloat margin = (self.view.bounds.size.width -20 - (BUTTON_WIDTH * COL_COUNT))/(COL_COUNT-1);
        //POINTX
        CGFloat buttonx =  (BUTTON_WIDTH+ margin)*col;
        CGFloat buttony =  (BUTTON_HEIGHT+ 10)*row;
        uiButton.frame = CGRectMake(buttonx, buttony, BUTTON_WIDTH, BUTTON_HEIGHT);
        uiButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [uiButton setTitle:buttons[i] forState:UIControlStateNormal];
        [secondView addSubview:uiButton];
        [uiButton setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [uiButton setBackgroundColor:[UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1.0]];

    }
    
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(252);
        make.right.mas_equalTo(searchbutton.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
    }];
    
    /** 设置*/
    // 方法代理
    tableView.delegate = self;
    // 数据代理
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    
    /** 注册Cell*/
    [tableView registerNib:[UINib nibWithNibName:@"SurfaceListTableViewCell" bundle:nil] forCellReuseIdentifier:@"SurfaceListTableViewCell"];
    
    /** iOS 11*/
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self transData];

}

#pragma mark - TableView DataSource：代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SurfaceListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell select];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    SurfaceListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell deselect];
}

/**
 获取cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /** 获取Id*/
    static NSString *cellId = @"SurfaceListTableViewCell";
    /** 获取Cell*/
    SurfaceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    /** 赋值Cell*/
    cell.dataInfo = self.dataArray[indexPath.row];
    
    return cell;
}
#pragma mark - TableView Delegate：代理
//cell高度，子类重写吧
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - NetWork
- (void)transData {
    
    OrderInfo *p0 = [[OrderInfo alloc] init];
    p0.name= @"张三";
    p0.compay = @"134111123...";
    p0.arragetime = @"10";
    
    OrderInfo *p1 = [[OrderInfo alloc] init];
    p1.name = @"li三";
    p1.exectetime = @"1341323...";
    p1.status = @"test1";
    
    OrderInfo *p2 = [[OrderInfo alloc] init];
    p2.name = @"waang";
    p2.comfirmtime = @"132333...";
    p2.status = @"test2";
    
    self.dataArray = @[p0, p1, p2];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)search{
    NSLog(@"检索");
}

@end
