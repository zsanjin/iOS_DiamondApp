//
//  MultipleFunctionView.m
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/22.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "MultipleFunctionView.h"

#define MinMarginX_Item 5 //itemX 最小间距
#define MinMarginY_Item 5 //itemY 最小间距
#define MarginX 10 //左右间距
#define MarginY 10 //上下间距
#define ColNum 6 //列数

@interface MultipleFunctionView()

/** 名字数组*/
@property (nonatomic, copy) NSArray * funtionNameArray;

@end

@implementation MultipleFunctionView

/** 快速创建:默认6列*/
+ (instancetype)funtionViewWithFuntionNameArray:(NSArray *)funtionNameArray {
    
    return [self funtionViewWithFuntionNameArray:funtionNameArray andColNum:ColNum];
}
/** 快速创建:给定列数*/
+ (instancetype)funtionViewWithFuntionNameArray:(NSArray *)funtionNameArray andColNum:(NSInteger)colNum {
    
    MultipleFunctionView *view = [[MultipleFunctionView alloc] init];
    view.colNum = colNum;
    view.funtionNameArray = funtionNameArray;
    
    return view;
}
#pragma mark - Custom Method
-   (void)configSubViews {
    
    int colNum = (int)self.colNum;//列数
    int row = 0;//第几行
    int col = 0;//第几列

    CGFloat marginX = MarginX;//横轴间距
    CGFloat marginY = MarginY;//纵轴间距
    
    CGFloat itemX = 0;//X
    CGFloat itemY = 0;//Y
    
    CGFloat itemW = 80;//宽度
    CGFloat itemH = 30;//高度
    
    //item间距
    CGFloat marginItemX = (kScreenWidth - marginX * 2 - itemW * colNum ) / (colNum - 1);
   
    if (marginItemX < MinMarginX_Item) {//间距不小于5
        marginItemX = MinMarginX_Item;
        itemW = (kScreenWidth - marginX * 2 - (colNum - 1) * marginItemX) / colNum;
    }
    
    if (self.subviews.count > self.funtionNameArray.count) {//移除多余的控件
        
        for (int i = (int)self.funtionNameArray.count; i < self.subviews.count; i ++) {
            UIView *view = [self viewWithTag:i + DefaultBtnTag];
            [view removeFromSuperview];
        }
    }
    
    UIButton *lastBtn = nil;
    
    for (int i = 0; i < self.funtionNameArray.count; i ++) {
        
        UIButton *btn = [self viewWithTag:i + DefaultBtnTag];
        if (btn) {//已存在
            [btn setTitle:self.funtionNameArray[i] forState:UIControlStateNormal];
        }else {//新
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i + DefaultBtnTag;
            
            col = i % colNum;//第几列 决定X
            row = i / colNum;//第几行 决定Y

            itemX = marginX + col * (marginItemX + itemW);
            itemY = marginY + row * (MinMarginY_Item + itemH);
            
            btn.frame = CGRectMake(itemX, itemY, itemW, itemH);//设置按钮
            
            //add
            [self addSubview:btn];
            
            //setting
            [btn setTitle:self.funtionNameArray[i] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor lineColor];
//            XHBorderRadius(btn, 5, 0, [UIColor lineColor]);
            [btn setTitleColor:[UIColor t1] forState:UIControlStateNormal];
            
            btn.titleLabel.font = FontSystem(12);
            
            [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        lastBtn = btn;
    }
    //总高度
    _totalHeight = CGRectGetMaxY(lastBtn.frame) + marginY;
}

#pragma mark - Setter and Getter
- (void)setFuntionNameArray:(NSArray *)funtionNameArray {
    
    _funtionNameArray = funtionNameArray;
    [self configSubViews];
}
#pragma mark - Action
- (void)clickAction:(UIButton *)btn {//点击响应
    
    if (self.selectFunctionBlock) {
        self.selectFunctionBlock(self, btn.titleLabel.text, btn.tag - DefaultBtnTag);
    }
}

@end
