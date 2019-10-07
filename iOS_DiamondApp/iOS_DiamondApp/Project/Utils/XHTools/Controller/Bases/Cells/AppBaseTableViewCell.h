//
//  AppBaseTableViewCell.h
//  App_General_Template
//
//  Created by JXH on 2017/7/13.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppBaseTableViewCell;

@protocol AppBaseTableViewCellDelegate <NSObject>
/**
 处理cell的交互事件
 @param cell      tableviewcell
 @param clickInfo 传递的事件信息
 */
- (void)cell:(AppBaseTableViewCell *)cell InteractionEvent:(id)clickInfo;

@end

@interface AppBaseTableViewCell : UITableViewCell

/** indexPath：下标*/
@property (nonatomic,strong) NSIndexPath *indexPath;

/** delegate:点击事件代理*/
@property (assign, nonatomic) id<AppBaseTableViewCellDelegate> delegate;

/** 类创建下布局UI ： 子类重写*/
- (void)configSubViews;
/** 根据data展示UI ： 子类重写*/
- (void)configData:(id)data;

@end
