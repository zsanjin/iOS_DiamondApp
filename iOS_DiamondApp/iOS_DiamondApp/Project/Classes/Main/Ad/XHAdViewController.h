//
//  XHAdViewController.h
//  CarInWay
//
//  Created by MrYeL on 2018/6/26.
//  Copyright © 2018年 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>

/** App启动广告*/
@interface XHAdViewController : UIViewController

/** 广告加载完成回调*/
@property (nonatomic, copy) void(^adCompletedBlock)(BOOL complete);

@end
