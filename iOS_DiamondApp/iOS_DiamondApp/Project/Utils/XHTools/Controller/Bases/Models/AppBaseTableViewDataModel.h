//
//  AppBaseTableViewDataModel.h
//  App_General_Template
//
//  Created by JXH on 2017/7/13.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppBaseTableViewDataModel : NSObject
/** 所有数据：AllData:无论是单个元素，还是所有元素，都是通过包一层可变数组添加到section中的*/
@property (nonatomic, copy, readonly) NSMutableDictionary *allDataDic;

//添加（增）：单个/数组 （默认追加）
/** 添加一个对象在0区*/
- (void)addData:(id)data;
/** 添加数据对象data在section区 */
- (void)addData:(id)data atSection:(NSInteger)sec;
/** 添加一组数据datas在section区*/
- (void)addDatasFromArray:(NSArray *)datas atSection:(NSInteger)sec;

//删除：单个/数组
/** 删除0区指定索引的元素*/
- (void)removeDataAtIndex:(NSInteger)index;
/** 删除指定位置的元素*/
- (void)removeDataAtIndex:(NSInteger)index section:(NSInteger)sec;
/** 删除区里面所有元素，保留区*/
- (void)removeSectionAllElements:(NSInteger)sec;
/** 删除整个区*/
- (void)removeSection:(NSInteger)sec;
/** 移除所有数据*/
- (void)removeAllData;

//修改：单个/数组（几乎不用）
///** 交换0区下数据的位置（下标）*/
//- (void)changeDataIndex:(NSInteger)index withDataIndex:(NSInteger)index;
///** 交换X区下数据的位置（下标）*/
//- (void)changeSection:(NSInteger)sec dataIndex:(NSInteger)index withDataIndex:(NSInteger)index;


//查找：单个/数组
/** 查找0区Index的数据*/
- (id)objectAtIndex:(NSInteger)index;
/** 查找X区Index的数据*/
- (id)objectAtIndex:(NSInteger)index section:(NSInteger)sec;
@end
