//
//  SecondView.h
//  iOS_DiamondApp
//
//  Created by zhangsheng on 2019/1/21.
//  Copyright © 2019年 MrYeL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 代理  1、 声明协议(protocol)  **/
@protocol passValue<NSObject>
-(void)passedValue:(NSString*) inputValue;
@end

@interface SecondView : UIView

/** 代理  2、 声明代理（delegate） 指定协议 id<协议名称> **/
@property (nonatomic,weak) id<passValue> delegate;

@property (nonatomic,weak) UITextField *textField;

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString*)title;

//// 步骤3 提供模型
//@property (nonatomic, strong)CustomUIViewModel *model;

@end

NS_ASSUME_NONNULL_END
