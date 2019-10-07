//
//  PersonInfoTableViewCell.m
//  iOS_Learning_Demo
//
//  Created by MrYeL on 2019/1/15.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "PersonInfoTableViewCell.h"

@implementation PersonInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataInfo:(Person *)dataInfo {
    
    self.nameLabel.text = dataInfo.name;
    self.phoneLabel.text = dataInfo.phoneNum;
    
}

@end
