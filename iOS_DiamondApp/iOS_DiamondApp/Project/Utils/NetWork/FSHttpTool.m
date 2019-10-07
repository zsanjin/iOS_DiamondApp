//
//  FSHttpTool.m
//
//  Created by MrYeL on 2018/9/27.
//

#import "FSHttpTool.h"

static NSMutableDictionary *_taskDic;
/** Gif加载状态 */
static UIImageView *_gifView;
/** Gif背景 */
static UIView *_gifBackView;
/** 小范围的加载动画 */
static UIActivityIndicatorView *_indicatorView;
static MBProgressHUD *_mbProgressHUD;

@implementation FSHttpTool

+ (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *afManager = [AFHTTPSessionManager manager];
    // 设置超时时间
#ifdef DEBUG
    afManager.requestSerializer.timeoutInterval = 8.f;
#else
    afManager.requestSerializer.timeoutInterval = 15.f;
#endif
    afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    return afManager;
}
/** put*/
+ (NSURLSessionTask *)putWithLoading:(BOOL)loading WaitingInView:(UIView *)view WithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block {
    
    YYReachability *re = [YYReachability reachability];
    if (re.status == 0) {
        showErrorMessage(@"您的网络已断开，请开启网络")
        return nil;
    }
    MBProgressHUD *mb;

    if (loading) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (view == nil) {
            //        [self showGifLodingInView:window isFull:YES];
            mb = [MBProgressHUD showHUDAddedTo:window animated:YES];
        } else {
            //        [self showGifLodingInView:view isFull:NO];
            mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
        mb.label.text = @"请稍等";
    }
    __weak typeof(MBProgressHUD * ) __weakProgressView = mb;

    
    //请求参数
    NSMutableDictionary *params = nil;
    if (![dic isKindOfClass:[NSDictionary class]]) {
        params = [NSMutableDictionary new];
    }else {
        params = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
    /* 返回参数信息 */
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [requestParams setObject:url forKeyedSubscript:@"request_url"];
    
    /**取消之前的重复请求*/
    if (self.taskDic[[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]]) {
        NSURLSessionTask *task = self.taskDic[[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
        [task cancel];
    }
    
   
    NSURLSessionTask *task =   [[self manager] PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [__weakProgressView hideAnimated:YES afterDelay:0.f];
            [__weakProgressView removeFromSuperview];
            [self.taskDic removeObjectForKey:[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
            if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSMutableDictionary class]]) {
                
                block(requestParams, responseObject, nil);
            }
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
        dispatch_async(dispatch_get_main_queue(), ^{
            [__weakProgressView hideAnimated:YES afterDelay:0.f];
            [__weakProgressView removeFromSuperview];
            [self.taskDic removeObjectForKey:[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
            block(requestParams, nil, error);
            [self showErrorMessageWithError:error];
        });
        
    }];
        
    /** 存储请求*/
    [self.taskDic setObject:task forKeyedSubscript:[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
    
    return task;
    
}
/**基础get*/
+ (NSURLSessionTask *)getWithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block {
    
    YYReachability *re = [YYReachability reachability];
    if (re.status == 0) {
        showErrorMessage(@"您的网络已断开，请开启网络");
        return nil;
    }
    //请求参数
    NSMutableDictionary *params = nil;
    if (![dic isKindOfClass:[NSDictionary class]]) {
        params = [NSMutableDictionary new];
    }else {
        params = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
    
    //额外添加信息
    if (![[params objectForKey:@"userID"] length]) {
        if (GetUser_Id.length) {
            [params setObject:GetUser_Id forKeyedSubscript:@"userID"];
        }
    }
    [params setObject:@"1" forKeyedSubscript:@"requestSource"];
    
    
    /* 返回参数信息 */
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [requestParams setObject:url forKeyedSubscript:@"request_url"];
    
    /**取消之前的重复请求*/
    if (self.taskDic[[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]]) {
        NSURLSessionTask *task = self.taskDic[[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
        [task cancel];
    }
    
    /** 开始请求*/
    NSURLSessionTask *task = [[self manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.taskDic removeObjectForKey:[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
            if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSMutableDictionary class]]) {
                
                block(requestParams, responseObject, nil);
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.taskDic removeObjectForKey:[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
            block(requestParams, nil, error);
            [self showErrorMessageWithError:error];
        });
        
    }];
    /** 存储请求*/
    [self.taskDic setObject:task forKeyedSubscript:[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
    
    return task;
    
}
/**
 get带加载动画 @param view 在哪个view上显示加载动画 || 写nil 挂window 全屏 禁止用户一切操作 */
+ (NSURLSessionTask *)getWithWaitingView:(UIView *)view WithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block {
    
    YYReachability *re = [YYReachability reachability];
    if (re.status == 0) {
        showErrorMessage(@"您的网络已断开，请开启网络")
        return nil;
    }
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *mb;
    if (view == nil) {
        //        [self showGifLodingInView:window isFull:YES];
        mb = [MBProgressHUD showHUDAddedTo:window animated:YES];
    } else {
        //        [self showGifLodingInView:view isFull:NO];
        mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    mb.label.text = @"请稍等";
    __weak typeof(MBProgressHUD * ) __weakProgressView = mb;
    
    NSURLSessionTask *task = [self getWithUrl:url withDic:dic withBlock:^(NSDictionary *requestParams, id result, NSError *error) {
        //        [ws hideGufLoding];
        [__weakProgressView hideAnimated:YES afterDelay:0.f];
        [__weakProgressView removeFromSuperview];
        
        if (result) {
            block(requestParams, result, nil);
        } else {
            block(requestParams, nil, error);
        }
    }];
    return task;
}
/**
 get带缓存
 @param view 加载动画放在哪个上面, 如果为nil 则无加载动画
 @param cacheType 缓存选择
 */
+ (NSURLSessionTask *)getWithCacheDataWithWaitingView:(UIView *)view withCacheType:(NetCacheType)cacheType withUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpCacheFinishBlock)block {
    
    if (dic == nil) {
        dic = [NSMutableDictionary new];
    }
    
    NSMutableDictionary *cacheDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSURLSessionTask *task = [[NSURLSessionTask alloc] init];
    
    switch (cacheType) {
        case NetCacheType_GetCacheAndGetNewData: {//获取缓存与网络
            
            NSDictionary *data = [FSNetworkCache httpCacheForURL:url parameters:cacheDic];
            //优先缓存
            if (data != nil) {
                block(dic, data, nil, NetResponseType_SuccessCache);
            }
            YYReachability *re = [YYReachability reachability];
            if (re.status == 0) {
                showErrorMessage(@"您的网络已断开，请开启网络")
                return nil;
            }
            //其次网络
            if (view != nil) {
                task = [self getWithWaitingView:view WithUrl:url withDic:dic withBlock:^(NSDictionary *requestParams, id result, NSError *error) {
                    if (result) {
                        [FSNetworkCache setHttpCache:result URL:url parameters:cacheDic];
                        block(requestParams, result, nil, NetResponseType_SuccessNet);
                    } else {
                        block(requestParams, nil, error, NetResponseType_FailedNet);
                    }
                }];
            } else {
                task = [self postWithUrl:url withDic:dic withBlock:^(NSDictionary *requestParams, id result, NSError *error) {
                    if (result) {
                        [FSNetworkCache setHttpCache:result URL:url parameters:cacheDic];
                        block(requestParams, result, nil, NetResponseType_SuccessNet);
                    } else {
                        block(requestParams, nil, error, NetResponseType_FailedNet);
                    }
                }];
            }
        }
            break;
            
        case NetCacheType_GetCacheOlny: {//只获取缓存
            
            NSDictionary *data = [FSNetworkCache httpCacheForURL:url parameters:cacheDic];
            if (data != nil) {
                block(dic, data, nil, NetResponseType_SuccessCache);
            } else {
                task = [self postWithUrl:url withDic:dic withBlock:^(NSDictionary *requestParams, id result, NSError *error) {
                    if (result) {
                        [FSNetworkCache setHttpCache:result URL:url parameters:cacheDic];
                        block(requestParams, result, nil, NetResponseType_SuccessNet);
                    } else {
                        block(requestParams, nil, error, NetResponseType_FailedNet);
                    }
                }];
            }
        }
            break;
        default:
            break;
    }
    return task;
    
}
#pragma mark 基础Post
+ (NSURLSessionTask *)postWithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block {
    
    YYReachability *re = [YYReachability reachability];
    if (re.status == 0) {
        showErrorMessage(@"您的网络已断开，请开启网络");
        return nil;
    }
    
    //请求参数
    NSMutableDictionary *params = nil;
    if (![dic isKindOfClass:[NSDictionary class]]) {
        params = [NSMutableDictionary new];
    }else {
        params = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
    
    //额外添加信息
    if (![[params objectForKey:@"userID"] length]) {
        if (GetUser_Id.length) {
            [params setObject:GetUser_Id forKeyedSubscript:@"userID"];
        }
    }
    [params setObject:@"1" forKeyedSubscript:@"requestSource"];

    
    /* 返回参数信息 */
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [requestParams setObject:url forKeyedSubscript:@"request_url"];
    
    /**取消之前的重复请求*/
    if (self.taskDic[[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]]) {
        NSURLSessionTask *task = self.taskDic[[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
        [task cancel];
    }
    /** 开始请求*/
   NSURLSessionTask *task = [[self manager] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.taskDic removeObjectForKey:[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
            if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSMutableDictionary class]]) {
                
                block(requestParams, responseObject, nil);
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.taskDic removeObjectForKey:[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
            block(requestParams, nil, error);
            [self showErrorMessageWithError:error];
        });
        
    }];
    /** 存储请求*/
    [self.taskDic setObject:task forKeyedSubscript:[FSNetworkCache cacheKeyWithURL:url parameters:requestParams]];
    
    return task;
}

#pragma mark post带加载动画
+ (NSURLSessionTask *)postWithWaitingView:(UIView *)view WithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block {
   
    YYReachability *re = [YYReachability reachability];
    if (re.status == 0) {
        showErrorMessage(@"您的网络已断开，请开启网络")
        return nil;
    }
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *mb;
    if (view == nil) {
        //        [self showGifLodingInView:window isFull:YES];
        mb = [MBProgressHUD showHUDAddedTo:window animated:YES];
    } else {
        //        [self showGifLodingInView:view isFull:NO];
        mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    mb.label.text = @"请稍等";
    __weak typeof(MBProgressHUD * ) __weakProgressView = mb;
    
    NSURLSessionTask *task = [self postWithUrl:url withDic:dic withBlock:^(NSDictionary *requestParams, id result, NSError *error) {
        //        [ws hideGufLoding];
        [__weakProgressView hideAnimated:YES afterDelay:0.f];
        [__weakProgressView removeFromSuperview];
        
        if (result) {
            block(requestParams, result, nil);
        } else {
            block(requestParams, nil, error);
        }
    }];
    return task;
}

#pragma mark 带缓存的post请求
+ (NSURLSessionTask *)postWithCacheDataWithWaitingView:(UIView *)view
                                         withCacheType:(NetCacheType)cacheType
                                               withUrl:(NSString *)url
                                               withDic:(NSDictionary *)dic
                                             withBlock:(NetHttpCacheFinishBlock)block {
    
    if (dic == nil) {
        dic = [NSMutableDictionary new];
    }
    
    NSMutableDictionary *cacheDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSURLSessionTask *task = [[NSURLSessionTask alloc] init];
    
    switch (cacheType) {
        case NetCacheType_GetCacheAndGetNewData: {//获取缓存与网络
            
            NSDictionary *data = [FSNetworkCache httpCacheForURL:url parameters:cacheDic];
            //优先缓存
            if (data != nil) {
                block(dic, data, nil, NetResponseType_SuccessCache);
            }
            YYReachability *re = [YYReachability reachability];
            if (re.status == 0) {
                showErrorMessage(@"您的网络已断开，请开启网络")
                return nil;
            }
            //其次网络
            if (view != nil) {
                task = [self postWithWaitingView:view WithUrl:url withDic:dic withBlock:^(NSDictionary *requestParams, id result, NSError *error) {
                    if (result) {
                        [FSNetworkCache setHttpCache:result URL:url parameters:cacheDic];
                        block(requestParams, result, nil, NetResponseType_SuccessNet);
                    } else {
                        block(requestParams, nil, error, NetResponseType_FailedNet);
                    }
                }];
            } else {
                task = [self postWithUrl:url withDic:dic withBlock:^(NSDictionary *requestParams, id result, NSError *error) {
                    if (result) {
                        [FSNetworkCache setHttpCache:result URL:url parameters:cacheDic];
                        block(requestParams, result, nil, NetResponseType_SuccessNet);
                    } else {
                        block(requestParams, nil, error, NetResponseType_FailedNet);
                    }
                }];
            }
        }
            break;
            
        case NetCacheType_GetCacheOlny: {//只获取缓存
            
            NSDictionary *data = [FSNetworkCache httpCacheForURL:url parameters:cacheDic];
            if (data != nil) {
                block(dic, data, nil, NetResponseType_SuccessCache);
            } else {
                task = [self postWithUrl:url withDic:dic withBlock:^(NSDictionary *requestParams, id result, NSError *error) {
                    if (result) {
                        [FSNetworkCache setHttpCache:result URL:url parameters:cacheDic];
                        block(requestParams, result, nil, NetResponseType_SuccessNet);
                    } else {
                        block(requestParams, nil, error, NetResponseType_FailedNet);
                    }
                }];
            }
        }
            break;
        default:
            break;
    }
    return task;
}
#pragma mark - 上传文件
+ (void)Upload:(NSString *)URLString
    parameters:(NSDictionary *)parameters
   uploadParam:(UploadParamModel *)uploadParam
 requestResult:(NetHttpFinishBlock)requestResult {
    
        [[self manager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSMutableDictionary class]]) {
                    
                    requestResult(parameters, responseObject, nil);
                }
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                requestResult(parameters, nil, error);
                [self showErrorMessageWithError:error];
            });
            
        }];

}
#pragma mark 加载动画
/**
 显示加载等待动画
 @param view 加载在哪
 @param isFull 是否需要全屏
 */
+ (void)showGifLodingInView:(UIView *)view isFull:(BOOL)isFull {
    _mbProgressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _mbProgressHUD.label.text = @"请稍等";
}

// 取消GIF加载动画
+ (void)hideGufLoding {
    [_mbProgressHUD hideAnimated:YES afterDelay:0.f];
    [_mbProgressHUD removeFromSuperview];

}
#pragma mark - Lazy load
+ (UIImageView *)gifView {
    
    if (_gifView == nil) {
        
        _gifView = [[UIImageView alloc] init];
    }
    return _gifView;
    
}
+ (UIView *)gifBackView {
    
    if (_gifBackView == nil) {
        
        _gifBackView = [[UIView alloc] initWithFrame:CGRectZero];
        _gifBackView.backgroundColor = [UIColor clearColor];
    }
    return _gifBackView;
}

+ (UIActivityIndicatorView *)indicatorView {
    
    if (_indicatorView == nil) {
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _indicatorView;
}

+ (NSMutableDictionary *)taskDic {
    if (!_taskDic) {
        _taskDic = [[NSMutableDictionary alloc] init];
    }
    return _taskDic;
}

#pragma mark 错误提示
+ (void)showErrorMessageWithError:(NSError *)error {
    if (error.code == -999) {
        return;
    }
    NSString *errorMesg = @"请检查网络";
    switch (error.code) {
        case -1://NSURLErrorUnknown
            errorMesg = @"无效的URL地址";
            break;
            //        case -999://NSURLErrorCancelled
            //            errorMesg = @"无效的URL地址";
            //            break;
        case -1000://NSURLErrorBadURL
            errorMesg = @"无效的URL地址";
            break;
        case -1001://NSURLErrorTimedOut
            errorMesg = @"网络不给力，请稍后再试";
            break;
        case -1002://NSURLErrorUnsupportedURL
            errorMesg = @"不支持的URL地址";
            break;
        case -1003://NSURLErrorCannotFindHost
            errorMesg = @"找不到服务器";
            break;
        case -1004://NSURLErrorCannotConnectToHost
            errorMesg = @"连接不上服务器";
            break;
        case -1103://NSURLErrorDataLengthExceedsMaximum
            errorMesg = @"请求数据长度超出最大限度";
            break;
        case -1005://NSURLErrorNetworkConnectionLost
            errorMesg = @"网络连接异常";
            break;
        case -1006://NSURLErrorDNSLookupFailed
            errorMesg = @"DNS查询失败";
            break;
        case -1007://NSURLErrorHTTPTooManyRedirects
            errorMesg = @"HTTP请求重定向";
            break;
        case -1008://NSURLErrorResourceUnavailable
            errorMesg = @"资源不可用";
            break;
        case -1009://NSURLErrorNotConnectedToInternet
            errorMesg = @"无网络连接";
            break;
        case -1010://NSURLErrorRedirectToNonExistentLocation
            errorMesg = @"重定向到不存在的位置";
            break;
        case -1011://NSURLErrorBadServerResponse
            errorMesg = @"服务器响应异常";
            break;
        case -1012://NSURLErrorUserCancelledAuthentication
            errorMesg = @"用户取消授权";
            break;
        case -1013://NSURLErrorUserAuthenticationRequired
            errorMesg = @"需要用户授权";
            break;
        case -1014://NSURLErrorZeroByteResource
            errorMesg = @"零字节资源";
            break;
        case -1015://NSURLErrorCannotDecodeRawData
            errorMesg = @"无法解码原始数据";
            break;
        case -1016://NSURLErrorCannotDecodeContentData
            errorMesg = @"无法解码内容数据";
            break;
        case -1017://NSURLErrorCannotParseResponse
            errorMesg = @"无法解析响应";
            break;
        case -1018://NSURLErrorInternationalRoamingOff
            errorMesg = @"国际漫游关闭";
            break;
        case -1019://NSURLErrorCallIsActive
            errorMesg = @"被叫激活";
            break;
        case -1020://NSURLErrorDataNotAllowed
            errorMesg = @"数据不被允许";
            break;
        case -1021://NSURLErrorRequestBodyStreamExhausted
            errorMesg = @"请求体";
            break;
        case -1100://NSURLErrorFileDoesNotExist
            errorMesg = @"文件不存在";
            break;
        case -1101://NSURLErrorFileIsDirectory
            errorMesg = @"文件是个目录";
            break;
        case -1102://NSURLErrorNoPermissionsToReadFile
            errorMesg = @"无读取文件权限";
            break;
        case -1200://NSURLErrorSecureConnectionFailed
            errorMesg = @"安全连接失败";
            break;
        case -1201://NSURLErrorServerCertificateHasBadDate
            errorMesg = @"服务器证书失效";
            break;
        case -1202://NSURLErrorServerCertificateUntrusted
            errorMesg = @"不被信任的服务器证书";
            break;
        case -1203://NSURLErrorServerCertificateHasUnknownRoot
            errorMesg = @"未知Root的服务器证书";
            break;
        case -1204://NSURLErrorServerCertificateNotYetValid
            errorMesg = @"服务器证书未生效";
            break;
        case -1205://NSURLErrorClientCertificateRejected
            errorMesg = @"客户端证书被拒";
            break;
        case -1206://NSURLErrorClientCertificateRequired
            errorMesg = @"需要客户端证书";
            break;
        case -2000://NSURLErrorCannotLoadFromNetwork
            errorMesg = @"无法从网络获取";
            break;
        case -3000://NSURLErrorCannotCreateFile
            errorMesg = @"无法创建文件";
            break;
        case -3001:// NSURLErrorCannotOpenFile
            errorMesg = @"无法打开文件";
            break;
        case -3002://NSURLErrorCannotCloseFile
            errorMesg = @"无法关闭文件";
            break;
        case -3003://NSURLErrorCannotWriteToFile
            errorMesg = @"无法写入文件";
            break;
        case -3004://NSURLErrorCannotRemoveFile
            errorMesg = @"无法删除文件";
            break;
        case -3005://NSURLErrorCannotMoveFile
            errorMesg = @"无法移动文件";
            break;
        case -3006://NSURLErrorDownloadDecodingFailedMidStream
            errorMesg = @"下载解码数据失败";
            break;
        case -3007://NSURLErrorDownloadDecodingFailedToComplete
            errorMesg = @"下载解码数据失败";
            break;
            
        default:
            break;
    }
    /* 网络有问题的提示 */
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = errorMesg;
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:2.f];
}
@end

#import "YYCache.h"

@implementation FSNetworkCache
static NSString *const NetworkResponseCache = @"FSNetworkCache";
static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
    [_dataCache.memoryCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if (!parameters) {return URL;};
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:URL];
    for (NSString *key in parameters.allKeys) {
        [arr addObject:key];
        [arr addObject:parameters[key]];
    }
    NSString *cacheKey = [arr componentsJoinedByString:@"&"];
    
    return cacheKey;
}

@end

@implementation UploadParamModel

@end
