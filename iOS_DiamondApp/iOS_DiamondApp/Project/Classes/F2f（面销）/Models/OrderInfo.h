//
//  OrderInfo.h
//  iOS_Learning_Demo
//
//  Created by zhangsheng on 2019/1/18.
//  Copyright © 2019年 MrYeL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderInfo : NSObject

/**姓名*/
@property (copy, nonatomic) NSString *name;

/**公司*/
@property (copy, nonatomic) NSString *compay;

/*后台预约时间*/
@property (copy, nonatomic) NSString *arragetime;

/**现场时间*/
@property (copy, nonatomic) NSString *comfirmtime;

/**上次执行时间*/
@property (copy, nonatomic) NSString *exectetime;

/**状态*/
@property (copy, nonatomic) NSString *status;



@end

NS_ASSUME_NONNULL_END
