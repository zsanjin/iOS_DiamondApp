//
//  LoginViewController.m
//  iOS_Learning_Demo
//
//  Created by zhangsheng on 2019/1/16.
//  Copyright © 2019年 MrYeL. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "SecondView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录界面";
    
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(139+NAVIGATION_BAR_HEIGHT);
        make.left.mas_equalTo(43);
        make.right.mas_equalTo(self.view.mas_centerX).offset(-5);
        make.height.mas_equalTo(121);
    }];
    [label layoutIfNeeded];
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString: @""];
    /**
     添加图片到指定的位置
     */
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = [UIImage imageNamed:@"diamond_1_50"];
    // 设置图片大小
    attchImage.bounds = label.bounds;
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    label.attributedText = attriStr;
    
    UILabel *mobileLabel = [[UILabel alloc] init];
     [self.view addSubview:mobileLabel];
    [mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(label.mas_bottom).offset(20);
        make.right.mas_equalTo(self.view.mas_left).offset(120);
        make.height.mas_equalTo(13);
    }];
    mobileLabel.text = @"手机号";
    
    self.mobileTextFiled = [[UITextField alloc] init];
    [self.view addSubview:self.mobileTextFiled];
    [self.mobileTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mobileLabel.mas_right);
        make.top.mas_equalTo(mobileLabel.mas_top);
        make.right.mas_equalTo(self.view.mas_right).offset(-45);
        make.height.mas_equalTo(13);
    }];
    [self.mobileTextFiled layoutIfNeeded];
    
    UIView *mobileView = [[UIView alloc]init];
    [self.view addSubview:mobileView];
    [mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(mobileLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-45);
        make.height.mas_equalTo(2);
    }];
    mobileView.backgroundColor = UIColor.grayColor;
    
    UILabel *checkCodeLabel = [[UILabel alloc] init];
    [self.view addSubview:checkCodeLabel];
    [checkCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(mobileLabel.mas_bottom).offset(36);  //self.view.mas_centerY).offset(10);
        make.right.mas_equalTo(self.view.mas_left).offset(120);
        make.height.mas_equalTo(13);
    }];
    checkCodeLabel.text = @"验证码";
    
    UITextField *checkCodeTextFiled = [[UITextField alloc] init];
    [self.view addSubview:checkCodeTextFiled];
    [checkCodeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(checkCodeLabel.mas_right);
        make.top.mas_equalTo(checkCodeLabel.mas_top);
        make.right.mas_equalTo(self.view.mas_right).offset(-129);
        make.height.mas_equalTo(13);
    }];
    
    UIView *codeView = [[UIView alloc]init];
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(checkCodeLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-45);
        make.height.mas_equalTo(2);
    }];
    codeView.backgroundColor = UIColor.grayColor;
    
    UILabel *sendCodeLabel = [[UILabel alloc] init];
    [self.view addSubview:sendCodeLabel];
    [sendCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_right).offset(-129);
        make.top.mas_equalTo(mobileLabel.mas_bottom).offset(36);  //self.view.mas_centerY).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(13);
    }];
    // 样式
    NSString *str = @"获取验证码";
    NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, str.length)];
    sendCodeLabel.attributedText = mastring;
    
    // 设置可点击
    sendCodeLabel.userInteractionEnabled=YES;
    //创建点击事件，点击的时候触发touchAble
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    //添加点击事件
    [sendCodeLabel addGestureRecognizer:labelTapGestureRecognizer];
    
    // UIbutton：声明、赋值样式
    UIButton *loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 将button 添加到view中
    [self.view addSubview:loginbutton];
    
    // 利用masonry惊醒约束布局
    [loginbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(checkCodeLabel.mas_left);
        make.right.mas_equalTo(self.mobileTextFiled.mas_right);
        make.top.mas_equalTo(checkCodeLabel.mas_bottom).offset(51);
        make.height.mas_equalTo(46);
    }];
    
    // 增加一个层
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    //因为利用了Masonry.h，后面不能宽高。https://www.jianshu.com/p/4676d84458f7
    [loginbutton layoutIfNeeded];
    // 设置层的长宽高和控件一致
    gradientLayer.frame = loginbutton.bounds;
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
    [loginbutton.layer addSublayer:gradientLayer];
    // 设置空间标题和样式
    [loginbutton setTitle:@"登录" forState:UIControlStateNormal];
    
    [loginbutton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor=UIColor.whiteColor;
    
    // UIbutton：声明、赋值样式

    SecondView *secondView = [[SecondView alloc]initWithFrame:CGRectZero andTitle: @"测试"];
    // 将button 添加到view中
//    [self.view addSubview:secondView];
    secondView.frame = CGRectMake(self.view.width-200,self.view.height-200, 200, 200);
    secondView.backgroundColor = UIColor.redColor;
    
    /** 代理  2、 指定子空间代理 ：本控件 **/
    secondView.delegate = self;

}

/** 代理  3、 实现代理方法 **/
-(void)passedValue:(NSString *) inputValue{
    self.mobileTextFiled.text = inputValue;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) login{
    NSLog(@"登录");
    __weak typeof(self) weakSelf = self;
    [weakSelf loginSucceed];
    
    if (weakSelf.loginSucceedBlock) {
        weakSelf.loginSucceedBlock();
    }
    
}

- (void)loginSucceed {
    
    if (![AppManager instance].userLoginInfo) {
        [AppManager instance].userLoginInfo = [AppUserInfoModel new];
    }
    [AppManager instance].userLoginInfo.userId = @"123";
    [[AppManager instance] saveUserLoginInfo];
    
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
//    UILabel *label=(UILabel*)recognizer.view;
    NSLog(@"被点击了");
}

//- shou shouldChangeCharactersInRange(){
//    
//}
- (void)dealloc {
    NSLog(@"%@: dealloced \n",NSStringFromClass(self.class));
    
}
@end
