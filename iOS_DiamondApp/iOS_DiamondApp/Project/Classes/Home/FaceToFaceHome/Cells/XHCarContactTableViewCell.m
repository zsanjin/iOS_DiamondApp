//
//  XHCarContactTableViewCell.m
//  Car
//
//  Created by MrYeL on 2017/11/13.
//  Copyright © 2017年 wyh. All rights reserved.
//

#import "XHCarContactTableViewCell.h"

#import "XHCarMineContactModel.h"

@interface XHCarContactTableViewCell ()

@end

@implementation XHCarContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.defaultContBtn.imageRect = CGRectMake(0, self.defaultContBtn.frame.size.height * 0.5 - 10, 20, 20);
    self.defaultContBtn.titleRect = CGRectMake(20 + 10, 0, self.defaultContBtn.frame.size.width - 30, self.defaultContBtn.frame.size.height);
    
    self.editBtn.imageRect = CGRectMake(0, self.editBtn.frame.size.height * 0.5 - 6, 12, 12);
    self.editBtn.titleRect = CGRectMake(6 + 12, 0, self.editBtn.frame.size.width - 18, self.defaultContBtn.frame.size.height);
    
    self.deleteBtn.imageRect = CGRectMake(0, self.deleteBtn.frame.size.height * 0.5 - 6, 12, 12);
    self.deleteBtn.titleRect = CGRectMake(6 + 12, 0, self.deleteBtn.frame.size.width - 18,self.deleteBtn.frame.size.height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configData:(XHCarMineContactModel *)data {
    
    if ([data isKindOfClass:[XHCarMineContactModel class]]) {
        
        
        self.defaultContBtn.userInteractionEnabled = YES;


        NSString *title = isNotEmptyValue(data.contact)?data.contact : [NSString stringWithFormat:@"好车会员%ld",self.indexPath.row];
        
        NSMutableString *mStr = [NSMutableString stringWithString:data.papersNo];

        if (mStr.length > 15) {
            [mStr replaceCharactersInRange:NSMakeRange(10, 4) withString:@"****"];

        }
        self.titleLabel.text = title;
        self.idNumLabel.text = mStr;
        self.phoneLabel.text = data.contactMobile;
        
        self.defaultContBtn.selected = data.isDefault;
        self.defaultContBtn.userInteractionEnabled = !data.isDefault;
    }
    
    
}
/** 设置为默认*/
- (IBAction)defaultAddressAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.userInteractionEnabled = NO;

    }
    
    if (self.delegate) {
        
        [self.delegate cell:self InteractionEvent:@(0)];
    }
    
}
/** 编辑*/
- (IBAction)editAction:(UIButton *)sender {
    
    if (self.delegate) {
        
        [self.delegate cell:self InteractionEvent:@(1)];
    }
    
}
/** 删除*/
- (IBAction)deleteAction:(UIButton *)sender {
    if (self.delegate) {
        
        [self.delegate cell:self InteractionEvent:@(2)];
    }
    
}

@end
