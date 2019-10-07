//
//  UIScrollView+Offset.m
//  App_General_Template
//
//  Created by JXH on 2017/7/20.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "UIScrollView+Offset.h"

static char offset;


@implementation UIScrollView (Offset)

- (void)addObserverOffset:(void(^)(CGPoint point))offsetBlock {
    self.offsetBlock = offsetBlock;
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    CGPoint point = [change[NSKeyValueChangeNewKey] CGPointValue];
    if (self.offsetBlock) {
        self.offsetBlock (point);
    }
}

- (void)removeObserverOffset {
    [self removeObserver:self forKeyPath:@"contentOffset"];
    self.offsetBlock = nil;
}



- (void)setOffsetBlock:(void (^)(CGPoint))offsetBlock {
    objc_setAssociatedObject(self, &offset, offsetBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void(^)(CGPoint))offsetBlock {
    
    return  objc_getAssociatedObject(self, &offset);
}
@end
