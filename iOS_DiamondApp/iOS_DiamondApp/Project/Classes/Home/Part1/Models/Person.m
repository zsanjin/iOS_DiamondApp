//
//  Person.m
//  iOS_Learning_Demo
//
//  Created by MrYeL on 2019/1/15.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initPWithName:(NSString *)name pWithPhoneNum:(NSString *)phoneNum pWithAge:(int)age
{
    self = [super init];
    if (self) {
        self.name = name;
        self.phoneNum = phoneNum;
        self.age = age;
        return self;
    }
    return self;
}

@end
