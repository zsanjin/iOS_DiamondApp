//
//  FaceToFaceHomeCell.h
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/23.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "AppBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaceToFaceHomeCell : AppBaseTableViewCell
/** 背景View*/
@property (nonatomic, strong) UIView * backView;
//用户名
@property (nonatomic, strong) UILabel *userNameLabel;
//手机号
@property (nonatomic, strong) UILabel *userPhoneLabel;

@end

NS_ASSUME_NONNULL_END
