//
//  FaceToFaceHomeXibCell.m
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/23.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "FaceToFaceHomeXibCell.h"

@implementation FaceToFaceHomeXibCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/** 重新赋值*/
- (void)configData:(id)data {
    
    if ([data isKindOfClass:[NSString class]]) {
        self.nameLabel.text = data;
    }
}

- (void)configSubViews {
    
    [super configSubViews];
    //添加视图
}

@end
