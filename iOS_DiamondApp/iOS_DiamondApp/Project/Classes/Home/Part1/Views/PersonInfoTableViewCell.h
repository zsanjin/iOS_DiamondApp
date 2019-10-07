//
//  PersonInfoTableViewCell.h
//  iOS_Learning_Demo
//
//  Created by MrYeL on 2019/1/15.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonInfoTableViewCell : UITableViewCell
/** 名字*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 手机号*/
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

/** dataInfo*/
@property (nonatomic, strong) Person * dataInfo;

@end

NS_ASSUME_NONNULL_END
