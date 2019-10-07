//
//  XHDrawer.h
//  CangoToB
//
//  Created by MrYeL on 2018/3/16.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHDrawer : UIView

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, copy) void (^selectIndex)(NSInteger index);
@property (nonatomic, copy) void (^selectInfo)(NSInteger index,NSString *clickInfo);

- (void)showDrawerViewWithTitleArray:(NSArray *)titleArray;

- (void)showDrawerTableViewWithTitleArray:(NSArray *)titleArray ;


@end
