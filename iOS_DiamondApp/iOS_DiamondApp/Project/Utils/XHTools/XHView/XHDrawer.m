//
//  XHDrawer.m
//  CangoToB
//
//  Created by MrYeL on 2018/3/16.
//  Copyright © 2018年 Kiddie. All rights reserved.
//

#import "XHDrawer.h"

@interface XHDrawer ()<UITableViewDelegate,UITableViewDataSource>

/** tableView*/
@property (nonatomic, strong) UITableView * tableView;
/** 数据*/
@property (nonatomic, copy) NSArray * titleArray;

@end

@implementation XHDrawer

#pragma mark - lazy load
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        XHBorderRadius(_tableView, 5, 0, [UIColor whiteColor]);

    }
    return _tableView;
    
}

#pragma mark - TableView
- (void)showDrawerTableViewWithTitleArray:(NSArray *)titleArray {
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    
    [self configTableViewWithTitleArray:titleArray];
    
}
- (void)configTableViewWithTitleArray:(NSArray *)titleArray {
    
    /** 底部基本*/
    CGFloat maxHeight = kScreenHeight - 75;
    maxHeight = titleArray.count * 45 > maxHeight? maxHeight:titleArray.count * 45 ;
    self.backgroundView = [XHTools xh_getUIViewWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight) withBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.backgroundView];
    
    /** 空白点击*/
    UIButton *hidenBtn = [XHTools xh_getUIButtonWithFrame:self.backgroundView.bounds withTitle:@"" withFont:15 withTarge:self withSel:@selector(hiddenDrawer)];
    [self.backgroundView addSubview:hidenBtn];
    /** 取消按钮*/
    UIButton *cancelBtn =     [XHTools xh_getUIButtonWithFrame:CGRectMake(15, self.backgroundView.height - 55, kScreenWidth - 30, 45) withTitle:@"取消" withFont:15 withTarge:self withSel:@selector(hiddenDrawer)];
    [cancelBtn setTitleColor:UIColorHexStr(@"3b3b3b") forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    XHBorderRadius(cancelBtn, 5, 0, [UIColor whiteColor]);
    [self.backgroundView addSubview:cancelBtn];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenDrawer)];
//    [self.backgroundView addGestureRecognizer:tap];

    //添加TabelView
    [self.backgroundView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(cancelBtn.mas_top).offset(-10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(maxHeight);
    }];
    
    self.titleArray = titleArray;
    
    //显示
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.backgroundView.frame;
        frame.origin.y -= (frame.size.height + HOME_INDICATOR_HEIGHT);
        self.backgroundView.frame = frame;
    }];
}
- (void)setTitleArray:(NSArray *)titleArray {
    
    _titleArray = titleArray;
    [self.tableView reloadData];
    
}
#pragma mark - TableView 代理开始
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor =UIColorHexStr(@"3b3b3b");
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [self.titleArray safeObjectAtIndex:indexPath.row];
    if (indexPath.row == self.titleArray.count - 1) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else {
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *clickInfo = [self.titleArray safeObjectAtIndex:indexPath.row];
    
    if (self.selectIndex) {
        self.selectIndex(indexPath.row);
        
    }
    if (self.selectInfo) {
        self.selectInfo(indexPath.row, clickInfo);
    }
    [self hiddenDrawer];
}

#pragma mark - Custom View
- (void)showDrawerViewWithTitleArray:(NSArray *)titleArray {
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenDrawer)];
    [self addGestureRecognizer:tap];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    [self makeBaseUIWithTitleArr:titleArray];
}
- (void)makeBaseUIWithTitleArr:(NSArray *)titleArr{
    self.backgroundView = [XHTools xh_getUIViewWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, titleArr.count * 45 + 65) withBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.backgroundView];
    UIButton *cancelBtn =     [XHTools xh_getUIButtonWithFrame:CGRectMake(15, self.backgroundView.height - 55, kScreenWidth - 30, 45) withTitle:@"取消" withFont:15 withTarge:self withSel:@selector(hiddenDrawer)];
    [cancelBtn setTitleColor:UIColorHexStr(@"3b3b3b") forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    XHBorderRadius(cancelBtn, 5, 0, [UIColor whiteColor]);
    [self.backgroundView addSubview:cancelBtn];
    //创建按钮
    //    CGRect fromValue = CGRectMake(15, kScreenHeight, kScreenWidth - 30, 45);
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [XHTools xh_getUIButtonWithFrame:CGRectMake(15, i * 45, kScreenWidth - 30, 45) withTitle:titleArr[i] withFont:15 withTarge:self withSel:@selector(click:)];
        [btn setTitleColor:UIColorHexStr(@"3b3b3b") forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i;
        //        POPSpringAnimation *popSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        ////        popSpring.springBounciness = 10;
        //        double delayInSeconds = i * 0.1;
        //        CFTimeInterval delay = delayInSeconds + CACurrentMediaTime();
        //        popSpring.beginTime = delay;
        //        popSpring.fromValue = [NSValue valueWithCGRect:fromValue];
        //        popSpring.toValue = [NSValue valueWithCGRect:CGRectMake(15, i * 45, kScreenWidth - 30, 45)];
        //        [btn pop_addAnimation:popSpring forKey:@"btnspopSpring"];
        //加线
        if (i != 0) {
            UIView *lineView = [XHTools xh_getUIViewWithFrame:CGRectMake(0, 0, kScreenWidth - 30, 0.5) withBackgroundColor:UIColorHexStr(@"e5e5e5")];
            [btn addSubview:lineView];
        }
        //修改圆角
        if (i == 0) {
            [self shapeRadiusWithView:btn withTop:YES];
        } else if (i == titleArr.count - 1) {
            [self shapeRadiusWithView:btn withTop:NO];
        }
        [self.backgroundView addSubview:btn];
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.backgroundView.frame;
        frame.origin.y -= (frame.size.height + HOME_INDICATOR_HEIGHT);
        self.backgroundView.frame = frame;
    }];
    
}
//改圆角
- (void)shapeRadiusWithView:(UIView *)view withTop:(BOOL)isTop {
    UIBezierPath *maskPath;
    if (isTop) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5,5)];
    } else {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5,5)];
    }
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
}
//点击按钮
- (void)click:(UIButton *)btn {
    
    if (self.selectIndex) {
        self.selectIndex(btn.tag);
        
    }
    if (self.selectInfo) {
        self.selectInfo(btn.tag, btn.titleLabel.text);
    }
    [self hiddenDrawer];
}

//隐藏
- (void)hiddenDrawer {
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
