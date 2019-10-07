//
//  FSHttpTool.h
//
//  Created by MrYeL on 2018/9/27.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
@class UploadParamModel;

#define isSucceedRequest (result && [result[@"code"] integerValue] == 0 && [result isKindOfClass:[NSDictionary class]])

#define showResponseMessage if (result != nil) {if ([result[@"code"] intValue] == 0) {[MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@",result[@"message"]] toView:nil];} else {if ([result[@"code"] intValue] == 1) {[MBProgressHUD showError:[NSString stringWithFormat:@"%@",result[@"message"]] toView:nil];} else {[MBProgressHUD showError:@"服务器开了会小差~" toView:nil];}return;}}else {return;}

#define showErrorResponseMessage if (result != nil) {if ([result[@"code"] intValue] != 0 && [result[@"code"] intValue] != 400) {[MBProgressHUD showError:[NSString stringWithFormat:@"%@",result[@"message"]] toView:nil];return;}} else {return;}

#define showResponseMessage_NoReturn  if (result != nil) {if ([result[@"code"] intValue] == 0) {[MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@",result[@"message"]] toView:nil];} else { [MBProgressHUD showError:[NSString stringWithFormat:@"%@",result[@"message"]] toView:nil];}}

typedef NS_ENUM(NSUInteger, FSNetworkStates) {
    NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
};
typedef NS_ENUM(NSUInteger, NetResponseType) {
    NetResponseType_SuccessNet,//从网络请求数据成功
    NetResponseType_FailedNet,//从网络请求数据失败
    NetResponseType_SuccessCache,//从缓存获取数据成功
};

typedef NS_ENUM(NSUInteger, NetCacheType) {
    NetCacheType_GetCacheAndGetNewData,//返回缓存并从网络请求
    NetCacheType_GetCacheOlny,//仅仅返回缓存
};

typedef void (^NetHttpFinishBlock)(NSDictionary *requestParams, id result, NSError *error);

typedef void (^NetHttpCacheFinishBlock)(NSDictionary *requestParams, id result, NSError *error, NetResponseType responseType);


@interface FSHttpTool : NSObject
/**基础get*/
+ (NSURLSessionTask *)getWithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block;
/**
 get带加载动画 @param view 在哪个view上显示加载动画 || 写nil 挂window 全屏 禁止用户一切操作 */
+ (NSURLSessionTask *)getWithWaitingView:(UIView *)view WithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block;
/**
 get带缓存
 @param view 加载动画放在哪个上面, 如果为nil 则无加载动画
 @param cacheType 缓存选择
 */
+ (NSURLSessionTask *)getWithCacheDataWithWaitingView:(UIView *)view withCacheType:(NetCacheType)cacheType withUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpCacheFinishBlock)block;


/**基础Post*/
+ (NSURLSessionTask *)postWithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block;

/**
 Post带加载动画 @param view 在哪个view上显示加载动画 || 写nil 挂window 全屏 禁止用户一切操作 */
+ (NSURLSessionTask *)postWithWaitingView:(UIView *)view WithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block;

/**
 Post带缓存
 @param view 加载动画放在哪个上面, 如果为nil 则无加载动画
 @param cacheType 缓存选择
 */
+ (NSURLSessionTask *)postWithCacheDataWithWaitingView:(UIView *)view withCacheType:(NetCacheType)cacheType withUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpCacheFinishBlock)block;


/** Put带加载动画 @param view 在哪个view上显示加载动画 || 写nil 挂window 全屏 禁止用户一切操作 */
+ (NSURLSessionTask *)putWithLoading:(BOOL)loading WaitingInView:(UIView *)view WithUrl:(NSString *)url withDic:(NSDictionary *)dic withBlock:(NetHttpFinishBlock)block;

/** 上传*/
+ (void)Upload:(NSString *)URLString
    parameters:(NSDictionary *)parameters
   uploadParam:(UploadParamModel *)uploadParam
 requestResult:(NetHttpFinishBlock)requestResult;


@end


#pragma mark - 网络数据缓存类
@interface FSNetworkCache : NSObject

/**
 *  异步缓存网络数据
 *
 *  @param httpData   服务器返回的数据
 *  @param URL        请求的URL地址
 *  @param parameters 请求的参数
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 *  根据请求的 URL与parameters 取出缓存数据
 *
 *  @param URL        请求的URL
 *  @param parameters 请求的参数
 *
 *  @return 缓存的服务器数据
 */
+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters;


/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize;


/**
 *  删除所有网络缓存,
 */
+ (void)removeAllHttpCache;

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters;

@end

@interface UploadParamModel : NSObject

/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器的文件名称
 *  @"image.jpg";
 *  @"image.png";
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  上传文件的类型
 *  @"图片：jpg/png";
 *  @"文件：json/txt";
 */
@property (nonatomic, copy) NSString *mimeType;

@end
