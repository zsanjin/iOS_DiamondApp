//
//  AppBaseTableView.h
//  App_General_Template
//
//  Created by JXH on 2017/7/13.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppBaseTableView : UITableView

/** 类注册*/
- (void)registCellWithClassArray:(NSArray *)classArray;
/** Xib注册*/
- (void)registCellWithNibArray:(NSArray *)nibArray;

/** 当前刷新页*/
@property (assign, nonatomic) NSInteger currentPage;
/** 刷新起始页*/
@property (assign, nonatomic) NSInteger originPage;


@end
