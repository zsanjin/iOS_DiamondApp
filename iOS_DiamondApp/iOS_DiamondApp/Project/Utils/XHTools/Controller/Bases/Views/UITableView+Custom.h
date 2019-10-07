//
//  UITableView+Custom.h
//  CangoToB
//
//  Created by MrYeL on 2018/4/9.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Custom)

/** 类注册*/
- (void)registCellWithClassArray:(NSArray *)classArray;
/** Xib注册*/
- (void)registCellWithNibArray:(NSArray *)nibArray;

/** 当前刷新页*/
@property (assign, nonatomic) NSInteger currentPage;
/** 刷新起始页*/
@property (assign, nonatomic) NSInteger originPage;

@end
