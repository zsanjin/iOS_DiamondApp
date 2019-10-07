//
//  FaceToFaceHomeCell.m
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/23.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "FaceToFaceHomeCell.h"

@implementation FaceToFaceHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - Life Cycle
- (void)configSubViews {
    
    self.contentView.backgroundColor = [UIColor t1];
    
    //ContentView
    UIView *backView = [UIView new];
    self.backView = backView;
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-10);
        
    }];
    
    //用户名
    self.userNameLabel = [XHTools getUILabelWithFrame:CGRectZero withTitle:nil withFont:15 withTextColor:[UIColor mainTextColor]];
    [backView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(15);
        make.right.equalTo(backView).offset(-15);
        make.left.equalTo(backView).offset(15);
        make.height.mas_equalTo(21);
    }];
    
    //手机号
    self.userPhoneLabel = [XHTools getUILabelWithFrame:CGRectZero withTitle:nil withFont:15 withTextColor:[UIColor mainTextColor]];
    [backView addSubview:self.userPhoneLabel];
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(9);
        make.left.equalTo(self.userNameLabel.mas_left);
        make.right.equalTo(self.backView.mas_right).offset(-15);
        make.bottom.equalTo(backView).offset(-5);
    }];
    
}

#pragma mark - Private Method
/** 合同列表数据*/
- (void)configData:(id)data{
    
    self.userNameLabel.text = @"测试用户";
    if (self.indexPath.row % 2) {
        
        self.userPhoneLabel.text = @"15195401349";
        
    }else{
        
        self.userPhoneLabel.text = @"米搜红红火火恍恍惚惚在马路上没V领什么了么法美股免费猫,米搜红红火火恍恍惚惚在马路上没V领什么了么法美股免费猫,米搜红红火火恍恍惚惚在马路上没V领什么了么法美股免费猫";

        
    }

}


@end
