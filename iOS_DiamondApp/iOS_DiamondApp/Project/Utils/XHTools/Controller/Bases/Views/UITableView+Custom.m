//
//  UITableView+Custom.m
//  CangoToB
//
//  Created by MrYeL on 2018/4/9.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import "UITableView+Custom.h"

#import "AppBaseTableViewCell.h"

static const void *UITableView_OriginalPage_Key = @"UITableView_OriginalPage_Key";
static const void *UITableView_CurrentPage_Key = @"UITableView_CurrentPage_Key";

@implementation UITableView (Custom)

//+ (void)load {
//    
//    
//}

- (void)setOriginPage:(NSInteger)originPage {
   
    objc_setAssociatedObject(self, UITableView_OriginalPage_Key, @(originPage), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSInteger)originPage {
    NSInteger key = [objc_getAssociatedObject(self, UITableView_OriginalPage_Key) integerValue];
    return key>0?key:1;
}
- (void)setCurrentPage:(NSInteger)currentPage {
   
    objc_setAssociatedObject(self, UITableView_CurrentPage_Key, @(currentPage), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSInteger)currentPage {
     NSInteger key = [objc_getAssociatedObject(self, UITableView_CurrentPage_Key) integerValue];
    return key>0?key:1;
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
