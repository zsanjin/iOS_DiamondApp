//
//  XHAdViewController.m
//  CarInWay
//
//  Created by MrYeL on 2018/6/26.
//  Copyright © 2018年 wyh. All rights reserved.
//

#import "XHAdViewController.h"

@interface XHAdViewController ()
{
    BOOL _skipAction;
}
/** 背景图*/
@property (nonatomic, strong) UIImageView * splashView;
/** 跳过*/
@property (nonatomic, weak) UIButton *skipBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) NSInteger count;

@end

@implementation XHAdViewController

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}
- (UIImageView *)splashView {
    
    if (_splashView == nil) {
        
        _splashView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _splashView.contentMode = UIViewContentModeScaleAspectFill;
        //添加点击事件
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_splashView addGestureRecognizer:tapGR];
        _splashView.userInteractionEnabled = YES;
        
    }
    return _splashView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加视图
    [self configSubViews];
    //请求参数
    [self transConfig];
}
- (void)configSubViews {
    
    //添加广告ImageView
    [self.view addSubview:self.splashView];
    [self.splashView setImageWithURL:[NSURL URLWithString:@""] placeholder:[UIImage imageNamed:@"launchDefault"]];

    //添加跳过按钮
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipBtn setTitle:@"3S 跳过" forState:UIControlStateNormal];
    [skipBtn addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    skipBtn.frame = CGRectMake(kScreenWidth - 70 - 15, NAVIGATION_BAR_HEIGHT - 30, 70, 35);
    skipBtn.layer.cornerRadius = 17.5;
    skipBtn.titleLabel.font = Font(14);
    [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    skipBtn.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.8];
    [self.splashView addSubview:skipBtn];
    skipBtn.hidden = YES;
    self.skipBtn = skipBtn;
    

}
#pragma mark - Action
- (void)tapAction{
    
    [AppManager instance].tapAd = YES;
    _skipAction = YES;
    [self moveToUpSide];
}
- (void)skipAction{
    
    _skipAction = YES;
    [self moveToUpSide];
    
}
#pragma mark - NetWork
/** 请求广告,更新本地，或者放在 prepare里请求*/
- (void)transConfig
{

    //获取当前系统的时间，并用相应的格式转换
    NSString *currentDayStr = [XHTools changeDateToString:[NSDate date] withFormatStr:@"yyyy-MM-dd HH:mm:ss"];
    //广告截止的时间，也用相同的格式去转换
    NSString * timeStampString = [AppManager instance].adInfo.EndTime;
    NSLog(@"当前日期：%@ 存下的截止日期：%@", currentDayStr, timeStampString);

    NSDate *deadlineDate = [XHTools chageStringToDate:timeStampString withFormatStr:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *currentDate = [XHTools chageStringToDate:currentDayStr withFormatStr:@"yyyy-MM-dd HH:mm:ss"];

    NSComparisonResult result;
    result = [deadlineDate compare:currentDate];
    /**
     *  将存下来的日期和当前日期相比，如果当前日期小于存下来的时间，则可以显示广告页，反之则不显示
     */
    if (result == NSOrderedAscending) {//不加载广告
        
        [self moveToUpSide];
        
    }else{//加载广告
        
        [self addSplashView];
    }

}
/** 添加广告*/
- (void)addSplashView
{
    if ([AppManager instance].adInfo) {
        //显示跳过
        self.skipBtn.hidden = NO;
        NSString *strStartPicUrl = [AppManager instance].adInfo.BigThumb;
        //加载图片
        [self.splashView setImageWithURL:[NSURL URLWithString:strStartPicUrl] placeholder:[UIImage imageNamed:@"launchDefault"]];
        //开始倒计时
        [self startTimer];
        
    }else {
        //返回
        [self moveToUpSide];

    }
    
}
// 定时器倒计时
- (void)startTimer
{
    _count = 3;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}
- (void)countDown
{
    _count --;
    [self.skipBtn setTitle:[NSString stringWithFormat:@"%ldS 跳过",(long)_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self moveToUpSide];
    }
}
- (void)moveToUpSide {
    
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    self.splashView.backgroundColor = UIColor.redColor;
    
    [UIView animateWithDuration:0.7 //速度0.7秒
                     animations:^{
                         [self.splashView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         
                         if (finished) {
                             
                             [self.splashView removeFromSuperview];
                         }
                         if (self.adCompletedBlock) {
                             self.adCompletedBlock(YES);
                         }
                     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    
    JLog(@"-[%@ dealloc]\n\n\n\n\n\n\n\n\n\n\n\n",NSStringFromClass([self class]));
}

@end
