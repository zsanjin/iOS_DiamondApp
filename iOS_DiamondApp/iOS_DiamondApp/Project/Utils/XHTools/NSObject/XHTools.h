//
//  XHTools.h
//  CangoToB
//
//  Created by MrYeL on 2018/3/8.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YHResetFrameButton.h"
#import "XHShowTimePicker.h"
#import "XHDrawer.h"


@interface XHTools : NSObject
/**UIView*/
+(UIView *)xh_getUIViewWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)backgroundColor;
/** 创建label*/
+ (UILabel *)xh_getUILabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(CGFloat)font textAligment:(NSTextAlignment)textAligment;
+ (UILabel *)getUILabelWithFrame:(CGRect)frame withTitle:(NSString *)title withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor;
/** 普通Btn*/
+(UIButton *)xh_getUIButtonWithFrame:(CGRect)rect withTitle:(NSString *)text withFont:(CGFloat)fontSize  withTarge:(id)target withSel:(SEL)sel;
+(UIButton *)xh_getUIButtonWithCustromWithFrame:(CGRect)rect withTitle:(NSString *)text withFont:(CGFloat)fontSize textColor:(UIColor*)textColor withBackgroundColor:(UIColor *)backgroundColor withTarge:(id)target withSel:(SEL)sel;
+(YHResetFrameButton *)xh_getUIButtonWithFrame:(CGRect)rect withTitle:(NSString *)title titleRect:(CGRect)titleRect withFont:(CGFloat)fontSize withImageName:(NSString *)imageName imageRect:(CGRect)imageRect withTarge:(id)target withSel:(SEL)sel;

/**ImageView*/
+ (UIImageView *)xh_getUIImageViewWithFrame:(CGRect)frame withImageName:(NSString *)imageName;
//date转string
+ (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat;
/**
 选择时间
 @param datePickerMode 时间格式
 @param isBeforeTime 是否可以选择现在之前的时间
 @param selectTimeBlock selectTimeBlock
 */
+ (void)showTimePIckerWithDatePickerMode:(UIDatePickerMode)datePickerMode withCanChooseBeforeTodayTime:(BOOL)isBeforeTime withAllBtn:(BOOL)showAll fromDate:(NSDate *)date andSelectTime:(DateTimeSelectWithType)selectTimeBlock;
+ (void)showTimePIckerWithDatePickerMode:(UIDatePickerMode)datePickerMode withCanChooseMinDate:(NSDate*)minDate withAllBtn:(BOOL)showAll andSelectTime:(DateTimeSelectWithType)selectTimeBlock;

/**
 底部弹出框
 @param titleArray 选择
 @param block index
 */
+ (void)showDrawerViewWithArray:(NSArray *)titleArray WithIndexAndClickInfo:(void(^)(NSInteger index,NSString *clickInfo))block;
+ (void)showDrawerTableViewWithArray:(NSArray *)titleArray WithIndexAndClickInfo:(void(^)(NSInteger index,NSString *clickInfo))block;


/** 获取 dete x年x月x天后（前）的时间*/
+ (NSDate *)historyOrFutureDateWithDate:(NSDate*)date yearCount:(NSInteger)yearCount mounthCount:(NSInteger)mounthCount dayCount:(NSInteger)dayCount;
//判断日期为多少之前或之后 calculateType:（年0、月1、日2、时3、分4、秒5）
+ (NSInteger)calculateDateStringBeforeOrFutureDateCount:(NSString *)dateString withType:(NSInteger)calculateType;
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/** 字符串转时间*/
+ (NSDate *)chageStringToDate:(NSString *)dateStr withFormatStr:(NSString *)format;
/** 时间转字符串*/
+ (NSString *)chageDateToString:(NSDate *)date withFormatStr:(NSString *)format;

#pragma mark - Car
/** 创建label*/
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(CGFloat)font textAligment:(NSTextAlignment)textAligment;
//Label两端对齐
+ (void)label:(UILabel *)label alightLeftAndRightWithWidth:(CGFloat)labelWidth;
//字符串转化成日期: 142123 -> n天前
+ (NSString *)timeStringFromDateString:(NSString *)dateString;
//clipImage：截取image
+(UIImage *)clipImage:(UIImage *)image withRect:(CGRect)rect;
/** * 画圆*/
+ (UIImage *)circleImage:(UIImage *)image;
//压缩图片尺寸
+(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
/** 计算文字尺寸*/
+ (CGSize)calculateSizeWithText:(NSString *)text maxSize:(CGSize)maxSize attributes:(NSDictionary *)attributes;
/** 通过文件名获取文件路径*/
+ (NSString *)fileSavePathWithfileName:(NSString *)fileName;
/** 获取当前系统日期时间YYYY-MM-dd*/
+ (NSString *)currentSystemTimeString;
/** 时间转字符串*/
//+ (NSDate *)chageStringToDate:(NSString *)dateStr withFormatStr:(NSString *)format;
/** 字符串转时间*/
+ (NSString *)changeDateToString:(NSDate *)date withFormatStr:(NSString *)format;
/** 手机号判断*/
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/** 是否可用密码*/
+ (BOOL)isValidPassword:(NSString *)password;
/** 网址判断*/
+ (BOOL)isWebUrl:(NSString *)content;
/** 最大并发数执行Block*/
+ (void)maxConcurrent_QueueWithMaxConcurrent_Count:(NSInteger)maxCount assignmentCount:(NSInteger)assigntnmetCount andAssignmentBlock:(void(^)(void))assignmentBlock;
/** 获取月份天数*/
+ (NSInteger)getMounthCountWithYearStr:(NSString *)yearStr andMounth:(NSString *)mounthStr;
//改圆角
+ (void)shapeRadiusWithView:(UIView *)view withTop:(BOOL)isTop;

@end
