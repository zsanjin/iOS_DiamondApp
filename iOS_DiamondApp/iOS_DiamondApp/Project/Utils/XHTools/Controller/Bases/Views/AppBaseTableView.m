//
//  AppBaseTableView.m
//  App_General_Template
//
//  Created by JXH on 2017/7/13.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "AppBaseTableView.h"

#import "AppBaseTableViewCell.h"

@implementation AppBaseTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Remove touch delay (since iOS 8)
    UIView *wrapView = self.subviews.firstObject;
    // UITableViewWrapperView
    if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
        for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
            // UIScrollViewDelayedTouchesBeganGestureRecognizer
            if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
                gesture.enabled = NO;
                break;
            }
        }
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}


/** 默认初始化*/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if ([super initWithFrame:frame style:style]) {
        
        [self registerClass:[AppBaseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AppBaseTableViewCell class])];
        
        [self initData];
    }
    
    return self;
}
/** 初始化设置*/
- (void)initData
{
    _currentPage = 1;
    self.originPage = 1;
}

/** 类注册*/
- (void)registCellWithClassArray:(NSArray *)classArray {
    
    if (!classArray.count) return;
    
    for (NSString *className in classArray) {
        
        if (className.length) {
            
            [self registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
        }
    }
    
}
/** Xib注册*/
- (void)registCellWithNibArray:(NSArray *)nibArray {
    
    if (!nibArray.count) return;
    
    for (NSString *nibName in nibArray) {
        
        if (nibName.length) {
            
            [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
        }
    }
}
@end

