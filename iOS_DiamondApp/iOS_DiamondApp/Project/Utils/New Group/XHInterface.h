//
//  XHInterface.h
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/2/18.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#ifndef XHInterface_h
#define XHInterface_h

#if DEBUG //调试模式

#define BASE_URL @"http://10.43.23.246:8800"

#else //发布模式

#define BASE_URL @"http://gps.cangoonline.com:86"

#endif

//Base拼接
#define BaseUrlWithRoute(Route) [NSString stringWithFormat:@"%@/%@",BASE_URL,Route]

//首页
/** 获取设备类型*/
#define Route_iGetGoodType BaseUrlWithRoute(@"api/BaseData/iGetGoodType")

//个人中心
/** */
#define Route_iGetUserInfo BaseUrlWithRoute(@"api/BaseData/iGetUserInfo")


#endif /* XHInterface_h */
