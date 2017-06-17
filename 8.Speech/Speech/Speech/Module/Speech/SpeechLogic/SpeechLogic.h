//
//  SpeechLogic.h
//  Speech
//
//  Created by Cain on 2017/6/17.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Speech/Speech.h>

@interface SpeechLogic : NSObject

- (instancetype)initSpeechWithLocalLanguage:(NSString *)language;

/**
 是否正在录制
 */
@property (nonatomic, assign) BOOL recording;

/**
 开始录音
 */
- (void)startRecording;

/**
 停止录音
 */
- (void)stopRecording;

/**
 返回从语音转成的文字, 错误信息
 */
@property (nonatomic, copy) void(^recognizeBlock)(NSString *string, NSString *error);

@end
