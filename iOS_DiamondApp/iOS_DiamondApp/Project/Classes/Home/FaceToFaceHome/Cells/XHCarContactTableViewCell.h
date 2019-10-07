//
//  XHCarContactTableViewCell.h
//  Car
//
//  Created by MrYeL on 2017/11/13.
//  Copyright © 2017年 wyh. All rights reserved.
//

#import "AppBaseTableViewCell.h"

@interface XHCarContactTableViewCell : AppBaseTableViewCell

@property (weak, nonatomic) IBOutlet YHResetFrameButton *defaultContBtn;
@property (weak, nonatomic) IBOutlet YHResetFrameButton *editBtn;
@property (weak, nonatomic) IBOutlet YHResetFrameButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *idNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
