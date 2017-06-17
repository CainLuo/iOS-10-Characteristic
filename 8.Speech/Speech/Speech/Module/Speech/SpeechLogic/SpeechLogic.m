//
//  SpeechLogic.m
//  Speech
//
//  Created by Cain on 2017/6/17.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SpeechLogic.h"

#define WEAK_SELF(type)  __weak __typeof(&*self)weakSelf = self

@interface SpeechLogic()

// 地方语言
@property (nonatomic, copy) NSString *localLanguage;

// 语音引擎, 负责提供语音输入
@property (nonatomic, strong) AVAudioEngine *audioEngine;

// 语音识别器
@property (nonatomic ,strong) SFSpeechRecognizer *speechRecognizer;

// 输出语音转换的内容结果
@property (nonatomic ,strong) SFSpeechRecognitionTask *recognitionTask;

// 处理识别语音请求
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;

@end

@implementation SpeechLogic

- (instancetype)initSpeechWithLocalLanguage:(NSString *)language {
    
    self = [super init];
    
    if (self) {
        
        self.localLanguage = language;
    }
    
    return self;
}

#pragma mark - 录音操作
- (void)startRecording {
    
    [self createRecognizer];
    [self createAudioEngine];
    [self createAudioSession];
    
    [self createAudioBufferRecognitionRequest];
    [self createSpeechRecognitionTask];
    
    AVAudioFormat *recordingFormat = [[self.audioEngine inputNode] outputFormatForBus:0];
    
    [[self.audioEngine inputNode] installTapOnBus:0
                                       bufferSize:1024
                                           format:recordingFormat
                                            block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
                                                
                                                [self.recognitionRequest appendAudioPCMBuffer:buffer];
                                            }];
    
    self.recording = YES;

    NSError *startError;

    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:&startError];
}

- (void)stopRecording {

    [self.audioEngine.inputNode removeTapOnBus:0];
    [self.audioEngine stop];

    [self.recognitionRequest endAudio];
    
    self.recording = NO;
}

#pragma mark - 创建音频会话
- (void)createAudioSession {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryRecord
                         mode:AVAudioSessionModeMeasurement
                      options:AVAudioSessionCategoryOptionDuckOthers
                        error:nil];
    [audioSession setActive:YES
                withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
                      error:nil];
}

#pragma mark - 初始化输出语音转换内容结果容器
- (void)createSpeechRecognitionTask {
    
    if (!self.recognitionTask) {
        
        self.recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:self.recognitionRequest
                                                                   resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
                                                                   
                                                                       if (error || result.isFinal) {
                                                                       
                                                                           NSLog(@"语音转换失败: %@", error.localizedDescription);
                                                                       
                                                                           [self stopRecording];
                                                                       
                                                                           if (self.recognizeBlock) {
                                                                               self.recognizeBlock(nil, error.localizedDescription);
                                                                           }
                                                                       
                                                                       } else {
                                                                       
                                                                           NSLog(@"语音转换成功: %@", result.bestTranscription.formattedString);
                                                                       
                                                                           if (self.recognizeBlock) {
                                                                               self.recognizeBlock(result.bestTranscription.formattedString, nil);
                                                                           }
                                                                       }
                                                                   }];
    }
}

#pragma mark - 初始化语音识别器
- (void)createRecognizer {
    
    if (!self.speechRecognizer) {
        
        self.speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:self.localLanguage]];
    }
}

#pragma mark - 初始化语音引擎
- (void)createAudioEngine {
    
    if (!self.audioEngine) {
        
        self.audioEngine = [[AVAudioEngine alloc] init];
    }
}

#pragma mark - 初始化语音发送请求
- (void)createAudioBufferRecognitionRequest {
    
    if (!self.recognitionRequest) {
        
        self.recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
        
        // 开启实时返回
        self.recognitionRequest.shouldReportPartialResults = YES;
    }
}

@end
