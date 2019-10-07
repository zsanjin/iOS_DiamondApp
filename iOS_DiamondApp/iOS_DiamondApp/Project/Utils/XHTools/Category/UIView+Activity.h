//
//  UIView+Activity.h
//  cango
//
//  Created by KiddieBao on 2017/3/21.
//  Copyright © 2017年 adu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Activity)
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)activityStyle;

- (void)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)activityStyle title:(NSString *)title viewController:(UIViewController *)controller;

- (void)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)activityStyle title:(NSString *)title;

- (void)removeActivityIndicatorWithTitle:(NSString *)title;

- (void)removeActivityIndicatorWithTitle:(NSString *)title viewController:(UIViewController *)controller;

- (void)popOutsideWithDuration:(NSTimeInterval)duration;
@end

//@interface UIBarButtonItem(Activity)
//@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
//
//- (void)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)activityStyle;
//
//- (void)removeActivityIndicatorWithTitle:(NSString *)title;
//@end

