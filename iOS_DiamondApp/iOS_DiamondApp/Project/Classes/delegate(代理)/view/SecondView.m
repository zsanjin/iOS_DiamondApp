//
//  SecondView.m
//  iOS_DiamondApp
//
//  Created by zhangsheng on 2019/1/21.
//  Copyright © 2019年 MrYeL. All rights reserved.
//

#import "SecondView.h"

@implementation SecondView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITextField *textField= [[UITextField alloc]init];
        
        self.textField=textField;
        [self addSubview:self.textField];
        
        [textField addTarget:self action:@selector(textField2TextChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        UITextField *textField= [[UITextField alloc]init];
        
        self.textField=textField;
        self.textField.text=title;
        [self addSubview:self.textField];
        
        [textField addTarget:self action:@selector(textField2TextChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.frame.size;
    self.textField.frame = CGRectMake(0, 0, size.width * 0.5, size.height * 0.5);
}

/** 代理  4、 子控件，调用方法 **/
-(void)textField2TextChange:(NSNotification *)noti{
    NSString *inputString = self.textField.text;
    /** 判断 1、代理是否赋值 2、是否实现协议方法**/
    if(self.delegate && [self.delegate respondsToSelector:@selector(passedValue:)]){
        /** 调用 调用协议方法。实现子控件值传递给父控件**/
        [self.delegate passedValue:inputString];
    }
}

@end
