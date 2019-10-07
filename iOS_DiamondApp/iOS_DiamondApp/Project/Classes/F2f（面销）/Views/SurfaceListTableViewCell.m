//
//  SurfaceListTableViewCell.m
//  iOS_Learning_Demo
//
//  Created by zhangsheng on 2019/1/17.
//  Copyright © 2019年 MrYeL. All rights reserved.
//

#import "SurfaceListTableViewCell.h"
#import "OrderInfo.h"

@implementation SurfaceListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 增加一个层
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    //因为利用了Masonry.h，后面不能宽高。https://www.jianshu.com/p/4676d84458f7
    // 设置层的长宽高和控件一致
    gradientLayer.frame = self.detail.bounds;
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
    [self.detail.layer addSublayer:gradientLayer];
    

   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataInfo:(OrderInfo *)dataInfo {
    
    self.username.text = dataInfo.name;
    self.company.text = dataInfo.compay;
    self.arragetime.text = dataInfo.arragetime;
    self.comfiretime.text = dataInfo.comfirmtime;
    self.executetime.text = dataInfo.exectetime;
    self.status.text = dataInfo.status;
    
}


- (void)select{
    self.username.top =self.username.superview.top+5;
    self.detail.hidden = false;
}

- (void)deselect{
    self.username.top =self.username.superview.top+10;
    self.detail.hidden = true;
}

@end
