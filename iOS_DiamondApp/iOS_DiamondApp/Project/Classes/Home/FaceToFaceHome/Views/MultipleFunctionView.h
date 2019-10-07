//
//  MultipleFunctionView.h
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/22.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultipleFunctionView : UIView
/** 点击回调*/
@property (nonatomic, copy) void(^selectFunctionBlock)(MultipleFunctionView *view,NSString *funtionName,NSInteger index);

/** View的高度*/
@property (nonatomic, assign, readonly) CGFloat totalHeight;

/** 列数*/
@property (nonatomic, assign) NSInteger colNum;

/** 快速创建:默认6列*/
+ (instancetype)funtionViewWithFuntionNameArray:(NSArray *)funtionNameArray;
/** 快速创建:给定列数*/
+ (instancetype)funtionViewWithFuntionNameArray:(NSArray *)funtionNameArray andColNum:(NSInteger)colNum;
@end

NS_ASSUME_NONNULL_END
