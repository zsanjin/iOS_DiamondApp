//
//  XHCarMineContactModel.h
//  Car
//
//  Created by MrYeL on 2017/11/17.
//  Copyright © 2017年 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHCarMineContactModel : NSObject

@property (nonatomic , assign) NSInteger  userId;
@property (nonatomic , copy) NSString              * papersType;
@property (nonatomic , copy) NSString              * papersNo;
@property (nonatomic , copy) NSString              * contact;
@property (nonatomic , assign) NSInteger           orderNo;
@property (nonatomic , copy) NSString              * contactMobile;
@property (nonatomic , copy) NSString              * contactType;
/** 默认地址*/
@property (nonatomic, assign) BOOL isDefault;
/** 常用地址*/
@property (nonatomic, assign) BOOL isUsual;

@property (nonatomic , assign) NSInteger   contactId;//ID

@end
