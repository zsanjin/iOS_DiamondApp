//
//  AppBaseTableViewDataModel.m
//  App_General_Template
//
//  Created by JXH on 2017/7/13.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "AppBaseTableViewDataModel.h"

@implementation AppBaseTableViewDataModel
@synthesize allDataDic = _allDataDic;

- (NSMutableDictionary *)allDataDic {
    if (_allDataDic == nil) {
        _allDataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _allDataDic;
}

//添加：单个/数组
/** 添加一个对象在0区*/
- (void)addData:(id)data{
    
    [self addData:data atSection:0];
    
}
/** 添加数据data在section区 */
- (void)addData:(id)data atSection:(NSInteger)sec{
    
    if (data) {
        
        //1.获取原数据数组并保存
        NSMutableArray *dataArray = [self originalDataArrayWithSec:sec];
        
        //2.添加新数据
        [dataArray addObject:data];
        
        
    }else {
        JLog(@"添加数据失败，数据源不能为nil");
    }
}
/** 添加一组数据datas在section区*/
- (void)addDatasFromArray:(NSArray *)datas atSection:(NSInteger)sec{
    
    if (datas.count) {
        
        //1.获取原数据数组并保存
        NSMutableArray *dataArray = [self originalDataArrayWithSec:sec];
        
        //2.添加新数据
        [dataArray addObjectsFromArray:datas];
        
        
    }else {
        JLog(@"添加数据失败，数组元素个数为0");
    }
}
/** 获取原数据数组并保存*/
- (NSMutableArray *)originalDataArrayWithSec:(NSInteger)sec {
    
    NSMutableArray *dataArray = [self.allDataDic objectForKey:@(sec)];
    
    if (!dataArray) {//不存在，创建并保存
        dataArray = [NSMutableArray new];
        [_allDataDic setObject:dataArray forKey:@(sec)];
        
    }
    //存在直接返回
    return dataArray;
}
//删除：单个/数组
/** 删除0区指定索引的元素*/
- (void)removeDataAtIndex:(NSInteger)index{
    
    [self removeDataAtIndex:index section:0];
}
/** 删除指定位置的元素*/
- (void)removeDataAtIndex:(NSInteger)index section:(NSInteger)sec{
    
    NSMutableArray *dataArray = [self.allDataDic objectForKey:@(sec)];
    
    if (dataArray.count > index) {
        
        [dataArray removeObjectAtIndex:index];
    }else {
        
        if (dataArray.count) {
            
            JLog(@"删除%d区第%d个元素失败,超过元素个数",index,sec);
        }else {
            JLog(@"删除%d区第%d个元素失败,数据源不存在",index,sec);
            
        }
    }
    
}
/** 删除区里面所有元素，保留区*/
- (void)removeSectionAllElements:(NSInteger)sec{
    
    NSMutableArray *dataArray = [self.allDataDic objectForKey:@(sec)];
    
    if (dataArray) {
        
        [dataArray removeAllObjects];
    }else {
        JLog(@"数据源不存在");
    }
}
/** 删除整个区*/
- (void)removeSection:(NSInteger)sec{
    
    [_allDataDic removeObjectForKey:@(sec)];
}
/** 移除所有数据*/
- (void)removeAllData{
    
    [_allDataDic removeAllObjects];
}

//修改：单个/数组（几乎不用）
///** 交换0区下数据的位置（下标）*/
//- (void)changeDataIndex:(NSInteger)index withDataIndex:(NSInteger)index{
//
//}
///** 交换X区下数据的位置（下标）*/
//- (void)changeSection:(NSInteger)sec dataIndex:(NSInteger)index withDataIndex:(NSInteger)index{
//
//}


//查找：单个/数组
/** 查找0区Index的数据*/
- (id)objectAtIndex:(NSInteger)index{
    
    return  [self objectAtIndex:index section:0];
    
}
/** 查找X区Index的数据*/
- (id)objectAtIndex:(NSInteger)index section:(NSInteger)sec{
    
    NSMutableArray *dataArray = [self.allDataDic objectForKey:@(sec)];
    
    id obj = nil;
    if (dataArray.count > index) {
        
        obj = [dataArray objectAtIndex:index];
    }
    else {
        
        JLog(@"超过数据源个数");
    }
    return obj;
}

@end
