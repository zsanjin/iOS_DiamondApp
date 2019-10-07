//
//  Person.h
//  iOS_Learning_Demo
//
//  Created by MrYeL on 2019/1/15.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

/** xingming*/
@property (nonatomic, copy) NSString * name;
/** shoujihao*/
@property (nonatomic, copy) NSString * phoneNum;
/** nianling*/
@property (nonatomic, assign) int age;

-(instancetype) initPWithName:(NSString *)name pWithPhoneNum:(NSString *)phoneNum pWithAge:(int)age;

@end

NS_ASSUME_NONNULL_END
