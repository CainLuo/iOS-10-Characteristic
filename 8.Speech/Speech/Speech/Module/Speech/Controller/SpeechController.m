//
//  SpeechController.m
//  Speech
//
//  Created by Cain on 2017/6/17.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SpeechController.h"
#import "SpeechView.h"
#import "SpeechLogic.h"

#define WEAK_SELF(type)  __weak __typeof(&*self)weakSelf = self

@interface SpeechController ()

@property (nonatomic, strong) SpeechView *speechView;

@property (nonatomic, strong) SpeechLogic *speechLogic;

@end

@implementation SpeechController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.speechView];
}

- (void)recording {
    
    WEAK_SELF(weakSelf);
    
    self.speechLogic = [[SpeechLogic alloc] initSpeechWithLocalLanguage:@"zh_CN"];
    
    [self.speechLogic setRecognizeBlock:^(NSString *content, NSString *error){
        
        [weakSelf.speechView changeLabelTextWithString:content];
    }];
}

- (SpeechView *)speechView {
    
    if (!_speechView) {
        
        WEAK_SELF(weakSelf);
        
        _speechView = [[SpeechView alloc] initWithFrame:self.view.frame];
        
        _speechView.backgroundColor = [UIColor lightTextColor];
        
        [_speechView setSpeechViewBlock:^(UIButton *sender){
            
            [weakSelf recording];
            
            if (sender.tag == 0) {
                
                if (!weakSelf.speechLogic.recording) {
                    
                    [weakSelf.speechLogic startRecording];
                    
                    [sender setTitle:@"停止录制" forState:UIControlStateNormal];
                    [sender setBackgroundColor:[UIColor redColor]];
                } else {
                    
                    [weakSelf.speechLogic stopRecording];
                    
                    [sender setTitle:@"开始录制" forState:UIControlStateNormal];
                    [sender setBackgroundColor:[UIColor greenColor]];
                }
                
            } else {
                
                [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                    
                    if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                        
                        [weakSelf readAudioWithSpeech];
                    }
                }];
            }
        }];
    }
    
    return _speechView;
}

- (void)readAudioWithSpeech {
    
    WEAK_SELF(weakSelf);

    //初始化音频的url
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test"
                                         withExtension:@"m4a"];
        
    SFSpeechRecognizer *recongize = [[SFSpeechRecognizer alloc] init];
    
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    
    [recongize recognitionTaskWithRequest:request
                            resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
                                
                                if (result) {
                                    
                                    [weakSelf.speechView changeLabelTextWithString:result.bestTranscription.formattedString];
                                }
                            }];
}

@end
