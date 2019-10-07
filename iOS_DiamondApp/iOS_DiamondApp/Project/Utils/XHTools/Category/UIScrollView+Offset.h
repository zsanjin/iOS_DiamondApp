//
//  UIScrollView+Offset.h
//  App_General_Template
//
//  Created by JXH on 2017/7/20.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Offset)

@property (nonatomic,copy)void(^offsetBlock)(CGPoint point);

- (void)addObserverOffset:(void(^)(CGPoint point))offsetBlock;

- (void)removeObserverOffset;

@end
