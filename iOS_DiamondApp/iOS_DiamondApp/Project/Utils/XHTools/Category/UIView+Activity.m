//
//  UIView+Activity.m
//  cango
//
//  Created by KiddieBao on 2017/3/21.
//  Copyright © 2017年 adu. All rights reserved.
//

#import "UIView+Activity.h"
#import <objc/runtime.h>

static char LZ_ACTIVITY_INDICATOR;
@implementation UIView (Activity)

@dynamic activityIndicator;

- (UIActivityIndicatorView *)activityIndicator {
    return (UIActivityIndicatorView *)objc_getAssociatedObject(self, &LZ_ACTIVITY_INDICATOR);
}

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator{
    objc_setAssociatedObject(self, &LZ_ACTIVITY_INDICATOR, activityIndicator, OBJC_ASSOCIATION_RETAIN);
}

- (void)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)activityStyle title:(NSString *)title viewController:(UIViewController *)controller{
    
    if (controller) {
        [controller.navigationItem setTitle:title];
    }
    
    [self addActivityIndicatorWithStyle:activityStyle title:title];
}

- (void)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)activityStyle title:(NSString *)title
{
    NSString *text = nil;
    
    if ([self isKindOfClass:[UIButton class]]) {
        text = ((UIButton *)self).titleLabel.text;
        self.userInteractionEnabled = false;
        
        [(UIButton *)self setTitle:title forState:UIControlStateNormal];
    }
    
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityStyle];
        
        self.activityIndicator.autoresizingMask = UIViewAutoresizingNone;
        
        self.activityIndicator.hidesWhenStopped = true;

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [self updateActivityIndicatorFrameWithTitle:title];
            
            [self addSubview:self.activityIndicator];
        });
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self.activityIndicator startAnimating];
    });
    

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.activityIndicator.animating) {
            [self removeActivityIndicatorWithTitle:text];
        }
    });
}

- (void)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)activityStyle {
    __block NSString *title = nil;
        if ([self isKindOfClass:[UIButton class]]) {
            title = ((UIButton *)self).titleLabel.text;
            self.userInteractionEnabled = false;
            [(UIButton *)self setTitle:@"" forState:UIControlStateNormal];
        }
    
    if ([self isKindOfClass:[UILabel class]]) {
        [(UILabel *)self setText:@""];
    }
    
        if (!self.activityIndicator) {
            self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityStyle];
            
            self.activityIndicator.autoresizingMask = UIViewAutoresizingNone;
            
            self.activityIndicator.hidesWhenStopped = true;
            
            [self updateActivityIndicatorFrame];
            
            [self addSubview:self.activityIndicator];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self.activityIndicator startAnimating];
        });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.activityIndicator.animating) {
            [self removeActivityIndicatorWithTitle:title];
        }
    });
}

-(void)updateActivityIndicatorFrame {
    if (self.activityIndicator) {
        CGRect activityIndicatorBounds = self.activityIndicator.bounds;
        float x = (self.frame.size.width - activityIndicatorBounds.size.width) / 2.0;
        float y = (self.frame.size.height - activityIndicatorBounds.size.height) / 2.0;
        self.activityIndicator.frame = CGRectMake(x, y, activityIndicatorBounds.size.width, activityIndicatorBounds.size.height);
    }
}

- (void)updateActivityIndicatorFrameWithTitle:(NSString *)title
{
    if (self.activityIndicator) {
        
        
     CGFloat titleWith = [title
         boundingRectWithSize:CGSizeMake(1000, 15)
         options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{NSFontAttributeName:[self isKindOfClass:[UIButton class]] ? ((UIButton *)self).titleLabel.font : [UIFont systemFontOfSize:17]}
         context:nil].size.width;
        
        CGRect activityIndicatorBounds = self.activityIndicator.bounds;
        float x = (self.frame.size.width - activityIndicatorBounds.size.width) / 2.0;
        float y = (self.frame.size.height - activityIndicatorBounds.size.height) / 2.0;
        self.activityIndicator.frame = CGRectMake(x, y, activityIndicatorBounds.size.width, activityIndicatorBounds.size.height);
        self.activityIndicator.center = CGPointMake(self.frame.size.width / 2 - titleWith / 2 - 12 - 5, self.activityIndicator.center.y);
    }
    
}


- (void)removeActivityIndicator {
   dispatch_async(dispatch_get_main_queue(), ^{
       if (self.activityIndicator) {
           [self.activityIndicator removeFromSuperview];
           self.activityIndicator = nil;
       }
   });
}

- (void)removeActivityIndicatorWithTitle:(NSString *)title viewController:(UIViewController *)controller{
    
    if (controller) {
        [controller.navigationItem setTitle:title];
    }
    [self removeActivityIndicator];
}

- (void)removeActivityIndicatorWithTitle:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isKindOfClass:[UIButton class]]) {
            self.userInteractionEnabled = true;
            UIButton *button = (UIButton *)self;
            [button setTitle:title forState:UIControlStateNormal];
        }
        
        if ([self isKindOfClass:UILabel.class]) {
            [(UILabel *)self setText:title];
        }
    });
    
    [self removeActivityIndicator];
}

- (void)popOutsideWithDuration:(NSTimeInterval)duration {
    
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(1.3f, 1.3f); // 放大
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(0.8f, 0.8f); // 放小
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f); //恢复原样
        }];
    } completion:nil];
}

@end
