//
//  BannerViewController.m
//  iOS_DiamondApp
//
//  Created by 蒋祥鸿 on 2019/2/20.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "BannerViewController.h"
#import "SDCycleScrollView.h"

#import "MultipleFunctionView.h"

@interface BannerViewController ()

/** bannerView*/
@property (nonatomic, strong) SDCycleScrollView * bannerView;
/** functions*/
@property (nonatomic, strong) MultipleFunctionView * functionView;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configSubViews];
    
    [self transData];
    
}

- (void)configSubViews {
    
    //banner
    SDCycleScrollView *bannerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, RATEHEIGHT_iPhone6(200))];
    bannerView.backgroundColor = UIColor.whiteColor;
    self.bannerView = bannerView;
    [self.view addSubview:bannerView];
    
    //functionView
    NSArray *funNameArray = @[@"Item0",@"Item1",@"Item2",@"Item3",@"Item4",@"Item5",@"Item6",@"Item7",@"Item8",@"Item9",@"Item10"];
    self.functionView = [MultipleFunctionView funtionViewWithFuntionNameArray:funNameArray andColNum:4];
    self.functionView.frame = CGRectMake(0, CGRectGetMaxY(bannerView.frame), kScreenWidth, self.functionView.totalHeight);
    [self.view addSubview:self.functionView];
    
    __weak typeof (self) weakSelf = self;
    self.functionView.selectFunctionBlock = ^(MultipleFunctionView * _Nonnull view, NSString * _Nonnull funtionName, NSInteger index) {
        
        [weakSelf.navigationController routePushViewController:@"NextViewController" withParams:@{kTitle:@"收车联系人"} animated:YES];

    };

}

- (void)transData {

//    NSDictionary *dict = @{@"name":@"zhansan",@"age":@"20"};
    
    [FSHttpTool postWithUrl:Route_iGetGoodType withDic:nil withBlock:^(NSDictionary *requestParams, id result, NSError *error) {
        
        if (isSucceedRequest) {
            
            // 解析赋值
      
        }else {
            JLog(@"请求失败，显示本地数据！");
            // 失败
            [self testData];
        }
        
    }];
    
   

}
- (void)testData {
    
    self.bannerView.imageURLStringsGroup = @[
                                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1550653959422&di=9554022869029c9951b19020561ad42b&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201505%2F29%2F20150529140658_CSzcW.jpeg",
                                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1550653959422&di=75eeae6d7012499b00aa2cbccb865e7b&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F1%2F5397be76675dd.jpg"];
}

@end
