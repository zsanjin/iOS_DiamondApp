//
//  NSArray+add.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/9.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "NSArray+add.h"

@implementation NSArray (add)
- (id)safeObjectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        if (index >= [self count]) return nil;
        return [self objectAtIndex:index];
    }
}
@end
