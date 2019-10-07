//
//  AppBaseTableViewCell.m
//  App_General_Template
//
//  Created by JXH on 2017/7/13.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "AppBaseTableViewCell.h"

@implementation AppBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)willDealloc{
    return false;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
        [self configSubViews];
        
    }
    return self;
}


#pragma mark - Custom Method
- (void)configSubViews {
    
    
}
/** 根据data展示UI*/
- (void)configData:(id)data {
    
    if ([data isKindOfClass:[NSString class]]) {
        
        self.textLabel.text = data;
    }else if ([data isKindOfClass:[NSDictionary class]]){
        
        self.textLabel.text = data[kTitle];
    }
}


@end
