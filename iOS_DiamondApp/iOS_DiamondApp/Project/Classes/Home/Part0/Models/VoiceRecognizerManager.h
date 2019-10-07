//
//  VoiceRecognizerManager.h
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/22.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RecognizeType){
    
    RecognizeType_Online,//在线语音听写
    RecognizeType_Offline,//离线语音听写
    RecognizeType_TranslateFile,//语音合成
};

//回调Block
@class VoiceRecognizerManager;
typedef void(^recognizeCompleteBlock)(VoiceRecognizerManager *manger,NSString *resultStr,NSString *errorStr);

/** 语音识别Manager*/
@interface VoiceRecognizerManager : NSObject

/** 识别的文字*/
@property (nonatomic, copy, readonly) NSString *soundString;
/** 语音识别*/
@property (nonatomic, copy) recognizeCompleteBlock completeBlock;
/** 识别的类型*/
@property (nonatomic, assign) RecognizeType type;


+ (instancetype)VoiceRecognizerWithRecognizeType:(RecognizeType)type;

/** Start:开始识别*/
- (void)startRecognizeWithFile:(id)file andComplete:(recognizeCompleteBlock)block;

/** Stop：停止识别*/
- (void)stopRecognize:(recognizeCompleteBlock)block;

/** Cancel：取消识别*/
- (void)cancelRecognize;

@end

/** 语音识别配置文件*/
@interface VoiceRecognizerConfig : NSObject

+(NSString *)mandarin;//普通话
+(NSString *)cantonese;//粤语
+(NSString *)henanese;//河南话
+(NSString *)chinese;//中文
+(NSString *)english;//英语
+(NSString *)dot;//是否标点
+(NSString *)speechTimeout;//最长录音时间、语音输入超时时间
+(NSString *)vadEos;//VAD后端点超时时间
+(NSString *)vadBos;//VAD前端点超时时间
+(NSString *)netTimeout;//网络连接超时时间
/**
 以下参数，需要通过
 iFlySpeechRecgonizer
 进行设置
 ****/
+(NSString *)sampleRate;//合成、识别、唤醒、评测、声纹等业务采样率
+(NSString *)language;//语言
+(NSString *)accent;//方言
/**
 以下参数无需设置
 不必关
 ****/
+(BOOL)haveView;
+(NSArray *)accentNickName;//accent方言



@end
