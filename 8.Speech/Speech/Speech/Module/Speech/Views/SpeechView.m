//
//  SpeechView.m
//  Speech
//
//  Created by Cain on 2017/6/16.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SpeechView.h"

@interface SpeechView()

@property (nonatomic, strong, readwrite) UILabel *speechLabel;

@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UIButton *readButton;

@end

@implementation SpeechView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.speechLabel];
        [self addSubview:self.recordButton];
        [self addSubview:self.readButton];
    }
    
    return self;
}

- (void)changeLabelTextWithString:(NSString *)string {
    
    if (string) {
        
        self.speechLabel.text = string;
    }
}

- (UILabel *)speechLabel {
    
    if (!_speechLabel) {
        
        CGFloat squareY = self.frame.size.height / 2 - 25;
        
        _speechLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                 squareY,
                                                                 self.frame.size.width,
                                                                 50)];
        
        _speechLabel.text            = @"等待输入";
        _speechLabel.textAlignment   = NSTextAlignmentCenter;
        _speechLabel.backgroundColor = [UIColor redColor];
    }
    
    return _speechLabel;
}

- (UIButton *)recordButton {
    
    if (!_recordButton) {
        
        _recordButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                   self.frame.size.height - 50,
                                                                   self.frame.size.width,
                                                                   50)];
        [_recordButton setTitleColor:[UIColor blackColor]
                            forState:UIControlStateNormal];
        [_recordButton setTitle:@"开始录音"
                       forState:UIControlStateNormal];
        [_recordButton setBackgroundColor:[UIColor greenColor]];
        [_recordButton addTarget:self
                          action:@selector(recordButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _recordButton;
}

- (void)recordButtonAction:(UIButton *)sender {
    
    if (self.speechViewBlock) {
        self.speechViewBlock(sender);
    }
}

- (UIButton *)readButton {
    
    if (!_readButton) {
        
        _readButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                 self.frame.size.height - 100,
                                                                 self.frame.size.width,
                                                                 50)];
        _readButton.tag = 1;
        
        [_readButton setTitleColor:[UIColor blackColor]
                          forState:UIControlStateNormal];
        [_readButton setTitle:@"开始读取"
                     forState:UIControlStateNormal];
        [_readButton setBackgroundColor:[UIColor cyanColor]];
        [_readButton addTarget:self
                        action:@selector(recordButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _readButton;
}

@end
