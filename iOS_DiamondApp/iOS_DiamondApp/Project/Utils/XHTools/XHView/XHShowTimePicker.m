//
//  XHShowTimePicker.m
//  CangoToB
//
//  Created by MrYeL on 2018/3/16.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import "XHShowTimePicker.h"

@interface XHShowTimePicker ()

@property (nonatomic, strong) UIView *backgroundView;
@property (strong, nonatomic) DateTimeSelect selectBlock;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *topView;
@property (strong, nonatomic) DateTimeSelectWithType selectBlockWithType;

@end

@implementation XHShowTimePicker
- (UIButton *)allTimeBtn {
    
    if (_allTimeBtn == nil) {
        
        _allTimeBtn = [XHTools xh_getUIButtonWithFrame:CGRectMake(self.topView.width - 15 - 35, 0, 35, 43.5) withTitle:@"全部" withFont:15 withTarge:self withSel:@selector(allTimeTypeClick)];
        [_allTimeBtn setTitleColor:UIColorHexStr(@"3F51B5") forState:UIControlStateNormal];
        _allTimeBtn.backgroundColor = [UIColor whiteColor];
        
        [self.topView addSubview:_allTimeBtn];
        
    }
    return _allTimeBtn;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleClick)];
        [self addGestureRecognizer:tap];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:self];
        [self makeBaseUI];
    }
    return self;
}
- (void)makeBaseUI {
    self.backgroundView = [XHTools xh_getUIViewWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 290) withBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.backgroundView];
    UIView *topView = [XHTools xh_getUIViewWithFrame:CGRectMake(15, 0, self.backgroundView.width - 30, 222) withBackgroundColor:[UIColor whiteColor]];
    self.topView = topView;
    [self.backgroundView addSubview:topView];
    self.titleLabel = [XHTools xh_getUILabelWithFrame:CGRectMake(21, 0, 200, 43.5) text:@"" textColor:[UIColor t2] font:15 textAligment:0];
    [topView addSubview:self.titleLabel];
    
    UIView *line = [XHTools xh_getUIViewWithFrame:CGRectMake(0, 43.5, topView.width, 0.5) withBackgroundColor:[UIColor t2]];
    [topView addSubview:line];
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.frame = CGRectMake(0, 44, topView.width, topView.height - 44);
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    self.datePicker.locale = locale;
    _selectDate = [NSDate new];
    self.datePicker.date = _selectDate;
    _titleLabel.text = [XHTools dateStringWithDate:_selectDate DateFormat:@"yyyy年MM月dd日"];
    self.datePicker.minimumDate = _selectDate;
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self.datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
    [topView addSubview:self.datePicker];
    
    XHBorderRadius(topView, 5, 0, [UIColor whiteColor]);
    
    UIButton *cancelBtn =  [XHTools xh_getUIButtonWithFrame:CGRectMake(15, self.backgroundView.height - 55, (kScreenWidth - 40)/2, 45) withTitle:@"取消" withFont:15 withTarge:self withSel:@selector(cancleClick)];
    [cancelBtn setTitleColor:UIColorHexStr(@"3b3b3b") forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];

    XHBorderRadius(cancelBtn, 5, 0, [UIColor whiteColor]);
    [self.backgroundView addSubview:cancelBtn];
    
    UIButton *conformBtn = [XHTools xh_getUIButtonWithFrame:CGRectMake(25 + (kScreenWidth - 40)/2, self.backgroundView.height - 55, (kScreenWidth - 40)/2, 45) withTitle:@"确定" withFont:15 withTarge:self withSel:@selector(confirmClick)];
    [conformBtn setTitleColor:UIColorHexStr(@"3b3b3b") forState:UIControlStateNormal];
    conformBtn.backgroundColor = [UIColor whiteColor];

    XHBorderRadius(conformBtn, 5, 0, [UIColor whiteColor]);
    [self.backgroundView addSubview:conformBtn];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.backgroundView.frame;
        frame.origin.y -= (frame.size.height + HOME_INDICATOR_HEIGHT);
        self.backgroundView.frame = frame;
    }];
}

- (void)setSelectDate:(NSDate *)selectDate
{
    _selectDate = selectDate;
    if (selectDate) {
        self.datePicker.date = selectDate;
    }
}

#pragma mark 设置时间选择的模式
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode
{
    self.datePicker.datePickerMode = datePickerMode;
}
#pragma mark 是否可以选择之前的时间
- (void)setIsBeforeTime:(BOOL)isBeforeTime
{
    if (isBeforeTime) {
        [self.datePicker setMinimumDate:[NSDate dateWithTimeIntervalSince1970:0]];
    }
    else {
        [self.datePicker setMinimumDate:[NSDate date]];
    }
}
#pragma mark 设置最小选择时间
- (void)setMinSelectDate:(NSDate *)minSelectDate
{
    if (minSelectDate) {
        [self.datePicker setMinimumDate:minSelectDate];
    }
}

#pragma mark 设置最大选择时间
- (void)setMaxSelectDate:(NSDate *)maxSelectDate
{
    if (maxSelectDate) {
        [self.datePicker setMaximumDate:maxSelectDate];
    }
}
#pragma mark DatePicker值改变
- (void)datePickerValueChange:(id)sender
{
    _selectDate = [sender date];
    _titleLabel.text = [XHTools dateStringWithDate:_selectDate DateFormat:@"yyyy年MM月dd日"];
}
- (void)didFinishSelectedDate:(DateTimeSelect)selectDataTime
{
    _selectBlock = selectDataTime;
}
- (void)didFinishSelectedDateWithType:(DateTimeSelectWithType)selectDataTime {
    
    _selectBlockWithType = selectDataTime;
}
#pragma mark 确定选择时间
//确定
- (void)confirmClick {
    if (_selectBlock) {
        _selectBlock(_selectDate,NO);
    }
    if (_selectBlockWithType) {
        _selectBlockWithType(_selectDate,TimeSelectType_Sure);
    }
    [self hiddenTImePicker];
}
//取消
- (void)cancleClick {
    if (_selectBlock) {
        _selectBlock(_selectDate,YES);
    }
    if (_selectBlockWithType) {
        _selectBlockWithType(_selectDate,TimeSelectType_Cancle);
    }
    [self hiddenTImePicker];
    
}
//全部
- (void)allTimeTypeClick {
    if (_selectBlockWithType) {
        _selectBlockWithType(_selectDate,TimeSelectType_All);
    }
    [self hiddenTImePicker];
}
- (void)hiddenTImePicker {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.backgroundView.frame;
        frame.origin.y += (frame.size.height + HOME_INDICATOR_HEIGHT);
        self.backgroundView.frame = frame;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}



@end
