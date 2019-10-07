//
//  YHResetFrameButton.h
//  hfhp
//
//  Created by wyh on 2017/5/5.
//  Copyright © 2017年 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DefaultBtnTag 1000

/** Color*/
static NSString *const kBtnBackGroundColor = @"btnBackGroundColor";
static NSString *const kTitleColor = @"btnTitleColor";
/** imageName*/
static NSString *const kBtnImageName = @"imageName";//change
static NSString *const kSelImageName = @"selImageName";
static NSString *const kBtnFontSize = @"btnfontSize";


@interface YHResetFrameButton : UIButton
@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
