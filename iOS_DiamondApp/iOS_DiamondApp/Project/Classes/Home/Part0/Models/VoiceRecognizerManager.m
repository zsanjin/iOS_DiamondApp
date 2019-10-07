//
//  VoiceRecognizerManager.m
//  iOS_DiamondApp
//
//  Created by MrYeL on 2019/1/22.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "VoiceRecognizerManager.h"

#import <iflyMSC/IFlySpeechRecognizer.h>//不带界面识别
#import <iflyMSC/iflyMSC.h>

@interface VoiceRecognizerManager()<IFlySpeechRecognizerDelegate>

/** 识别对象*/
@property (nonatomic, strong) IFlySpeechRecognizer * speechRecognizer;

@end

@implementation VoiceRecognizerManager

- (IFlySpeechRecognizer *)speechRecognizer {
    
    if (_speechRecognizer == nil) {
        _speechRecognizer = [IFlySpeechRecognizer sharedInstance];
    }
    return _speechRecognizer;
}

+ (instancetype)VoiceRecognizerWithRecognizeType:(RecognizeType)type {
    
    VoiceRecognizerManager *manager = [[VoiceRecognizerManager alloc] init];//初始化
    manager.type = type;//设置类型
    return manager;
}

#pragma mark - Setter and Getter
- (void)setType:(RecognizeType)type {
    
    _type = type;
    [self settingSpeechRecognizerParameWithType:type];
}
#pragma mark - TypeConfig: 语言识别配置
- (void)settingSpeechRecognizerParameWithType:(RecognizeType)type {
   
    /** 0.通用配置*/
    [self defaultConfig];
    
    /** 1.类型配置*/
    switch (self.type) {
        case RecognizeType_Online://在线语音听写
            [self onlineRecognizeConfig];
            break;
        case RecognizeType_Offline://离线语音听写
            [self offlineRecognizeConfig];
            break;
        case RecognizeType_TranslateFile://文件识别
            [self translateFileRecognizeConfig];
            break;
        default:
            break;
    }

}
/** 通用配置*/
- (void)defaultConfig {
    //扩展参数
    [self.speechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    //代理
    self.speechRecognizer.delegate = self;
    
}
#pragma mark - RecognizeType_Online.在线语音听写配置
/** RecognizeType_Online.在线语音听写配置*/
- (void)onlineRecognizeConfig {
    //一：
    //设置听写模式
    [self.speechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //二：
    //设置最长录音时间
    [_speechRecognizer setParameter:VoiceRecognizerConfig.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
    //设置后端点
    [_speechRecognizer setParameter:VoiceRecognizerConfig.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
    //设置前端点
    [_speechRecognizer setParameter:VoiceRecognizerConfig.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
    //网络等待时间
    [_speechRecognizer setParameter:VoiceRecognizerConfig.netTimeout forKey:[IFlySpeechConstant NET_TIMEOUT]];
    //设置采样率，推荐使用16K
    [_speechRecognizer setParameter:VoiceRecognizerConfig.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];

    //三：
    if ([VoiceRecognizerConfig.language isEqualToString:[VoiceRecognizerConfig chinese]]) {//中文
        //设置语言
        [_speechRecognizer setParameter:VoiceRecognizerConfig.language forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        [_speechRecognizer setParameter:VoiceRecognizerConfig.accent forKey:[IFlySpeechConstant ACCENT]];
        
    }else if ([VoiceRecognizerConfig.language isEqualToString:[VoiceRecognizerConfig english]]) {//英文
        
        [_speechRecognizer setParameter:VoiceRecognizerConfig.language forKey:[IFlySpeechConstant LANGUAGE]];
    }
    //四：
    //设置是否返回标点符号:设置是否带标点符号Value
    [_speechRecognizer setParameter:VoiceRecognizerConfig.dot forKey:VoiceRecognizerConfig.dot.integerValue>0?[IFlySpeechConstant ASR_PTT_HAVEDOT]:[IFlySpeechConstant ASR_PTT_NODOT]];
    //设置音频来源为麦克风
    [_speechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:[IFlySpeechConstant AUDIO_SOURCE]];
    //设置听写结果格式为json
    [_speechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    //        [_speechRecognizer setParameter:@"" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
}
#pragma mark - RecognizeType_offline.离线语音听写配置
/** RecognizeType_offline.离线语音听写*/
- (void)offlineRecognizeConfig {
    
    
}
#pragma mark - RecognizeType_TranslateFile.语音合成配置
/** RecognizeType_TranslateFile.语音合成配置*/
- (void)translateFileRecognizeConfig {

    
}
#pragma mark - IFlySpeechRecognizerDelegate ： 代理
//识别错误
- (void)onError:(IFlySpeechError *)error{
    
    [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
}
//识别结束回调
- (void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }//获得JSON数据
    
    //转为结果字符串
    NSString *resultFromJSON = [self stringFromJson:resultString];
    
    NSLog(@"result:%@\nresultFromJSON:%@",resultString, resultFromJSON);
    
    _soundString = resultFromJSON;
    
    /** 回调结果*/
    if (self.completeBlock) {
        
        self.completeBlock(self, _soundString, _soundString.length?@"":@"您好像没有说话");
    }
    /** 已识别取消继续识别*/
    if (_soundString.length >0) {
        
        [_speechRecognizer cancel];
    }
}
- (void)onCompleted:(IFlySpeechError *)errorCode {
    
    
}

#pragma mark - 其他
//语音JSON数据解析
- (NSString *)stringFromJson:(NSString*)params
{
    if (params == NULL) {//没有值
        return nil;
    }
    
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //返回的格式必须为utf8的,否则发生未知错误
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}
- (void)dealloc{
    
    [_speechRecognizer cancel]; //取消识别
    [_speechRecognizer setDelegate:nil];
    [_speechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
}

#pragma mark - Action
/** Start:开始识别*/
- (void)startRecognizeWithFile:(id)file andComplete:(recognizeCompleteBlock)block {
    if (block) {
        self.completeBlock = block;
    }
 
    switch (self.type) {
        case RecognizeType_Online://在线语音听写
            [self.speechRecognizer startListening];
            break;
        case RecognizeType_Offline://离线语音听写
            break;
        case RecognizeType_TranslateFile://文件识别
            break;
            
        default:
            break;
    }
    
}

/** Stop：停止识别*/
- (void)stopRecognize:(recognizeCompleteBlock)block {
    if (block) {
        self.completeBlock = block;
    }
    [self.speechRecognizer stopListening];
}

/** Cancel：取消识别*/
- (void)cancelRecognize {
    [self.speechRecognizer cancel];
}

@end

#define PUTONGHUA   @"mandarin"
#define YUEYU       @"cantonese"
#define HENANHUA    @"henanese"
#define ENGLISH     @"en_us"
#define CHINESE     @"zh_cn"

@implementation VoiceRecognizerConfig

+(NSString *)mandarin {//普通话
    return PUTONGHUA;
}
+(NSString *)cantonese {//粤语
    return YUEYU;
}
+(NSString *)henanese {//河南话
    return HENANHUA;
}
+(NSString *)chinese {//中文
    return CHINESE;
}
+(NSString *)english {//英语
    return ENGLISH;
}
+(NSString *)dot {//是否带标点符号
    return @"0";
}
+(NSString *)speechTimeout{//最长录音时间、语音输入超时时间
    return @"30000";
}
+(NSString *)vadEos {//VAD后端点超时时间
    return @"3000";
}
+(NSString *)vadBos {//是否带标点符号
    return @"3000";
}
+(NSString *)netTimeout{//网络连接超时时间
    return @"20000";
}
/**
 以下参数，需要通过
 iFlySpeechRecgonizer
 进行设置
 ****/
+(NSString *)sampleRate {//合成、识别、唤醒、评测、声纹等业务采样率
    
    return @"16000";
}
+(NSString *)language {//语言
    return CHINESE;
}
+(NSString *)accent {//方言
    return PUTONGHUA;
}
/**
 以下参数无需设置
 不必关
 ****/
+(BOOL)haveView {//是否带界面
    return NO;
}
+(NSArray *)accentNickName {//方言
    return @[@"粤语",@"普通话",@"河南话",@"英文"];
}

@end
