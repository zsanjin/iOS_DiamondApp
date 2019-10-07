//
//  TableViewDemoViewController.m
//  iOS_Learning_Demo
//
//  Created by MrYeL on 2019/1/15.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "TableViewDemoViewController.h"

#import "Person.h"
#import "PersonInfoTableViewCell.h"

@interface TableViewDemoViewController ()<UITableViewDelegate,UITableViewDataSource>

/** DataList*/
@property (nonatomic, copy) NSArray * dataArray;
/** TableView*/
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation TableViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"TableView使用";
    
    /**1.配置TableView*/
    [self configTableView];
    
    /**2.模拟数据*/
    [self transData];
}
#pragma mark - Custom Method
- (void)configTableView {
    
    /** 创建*/
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, kScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    /** 设置*/
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    /** 添加*/
    [self.view addSubview:self.tableView];
    
    
    /** 注册Cell*/
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"PersonInfoTableViewCell"];
    
    
    
    /** iOS 11*/
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
#pragma mark - NetWork
- (void)transData {
    
    Person *p0 = [[Person alloc] init];
    p0.name = @"张三";
    p0.phoneNum = @"134111123...";
    p0.age = 10;
    
    Person *p1 = [[Person alloc] init];
    p1.name = @"li三";
    p1.phoneNum = @"1341323...";
    p1.age = 13;
    
    Person *p2 = [[Person alloc] init];
    p2.name = @"waang";
    p2.phoneNum = @"132333...";
    p2.age = 15;
    
    self.dataArray = @[p0, p1, p2];
    
}
#pragma mark - TableView DataSource：代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
/**
 获取cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /** 获取Id*/
    static NSString *cellId = @"PersonInfoTableViewCell";
    /** 获取Cell*/
    PersonInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    /** 赋值Cell*/
    cell.dataInfo = self.dataArray[indexPath.row];

    return cell;
}
#pragma mark - TableView Delegate：代理
//cell高度，子类重写吧
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 60;
}

@end
