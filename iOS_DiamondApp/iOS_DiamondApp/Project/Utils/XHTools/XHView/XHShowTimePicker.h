//
//  XHShowTimePicker.h
//  CangoToB
//
//  Created by MrYeL on 2018/3/16.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TimeSelectType) {
    
    TimeSelectType_Cancle,//取消
    TimeSelectType_Sure,//确定
    TimeSelectType_All,//全部
    
};

typedef void (^DateTimeSelect)(NSDate *selectDataTime,BOOL isCancle);
typedef void (^DateTimeSelectWithType)(NSDate *selectDataTime,TimeSelectType selectType);

@interface XHShowTimePicker : UIView
/**
 默认不存在
 */
@property (nonatomic, strong) UIButton *allTimeBtn;
/**
 是否可选择当前时间之前的时间,默认为NO
 */
@property (nonatomic, assign) BOOL isBeforeTime;

/**
 选择时间
 */
@property (nonatomic, strong) NSDate *selectDate;

/**
 最小时间
 */
@property (nonatomic, strong) NSDate *minSelectDate;

/**
 最大时间
 */
@property (nonatomic, strong) NSDate *maxSelectDate;

/**
 DatePickerMode,默认是DateAndTime
 */
@property (nonatomic, assign) UIDatePickerMode datePickerMode;

/**
 选择的时间
 
 @param selectDataTime selectDataTime description
 */
- (void)didFinishSelectedDate:(DateTimeSelect)selectDataTime;
- (void)didFinishSelectedDateWithType:(DateTimeSelectWithType)selectDataTime;
@end
