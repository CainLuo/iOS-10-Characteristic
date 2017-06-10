//
//  MessageStartController.m
//  iMessageSimpleProject
//
//  Created by Cain on 2017/6/10.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "MessageStartController.h"
#import "Masonry.h"

@interface MessageStartController ()

@property (nonatomic, strong) UIButton *startButton;

@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation MessageStartController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.startButton];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.centerY.centerX;
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.centerX;
        make.bottom.equalTo(self.startButton.mas_top).offset(-20);
    }];
}

#pragma mark - Start Button
- (UIButton *)startButton {
    
    if (!_startButton) {
        
        _startButton = [[UIButton alloc] init];
        
        [_startButton setBackgroundColor:[UIColor whiteColor]];
        [_startButton setTitle:@"开始打开插件"
                      forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor blackColor]
                           forState:UIControlStateNormal];
        [_startButton addTarget:self
                         action:@selector(starButtonAction:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _startButton;
}

- (void)starButtonAction:(UIButton *)sender {
    
    if (self.messageStartBloack) {
        self.messageStartBloack(sender);
    }
}

#pragma mark - Tips Label
- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        
        _tipsLabel               = [[UILabel alloc] init];
        _tipsLabel.text          = @"Message Extension";
        _tipsLabel.font          = [UIFont systemFontOfSize:25];
        _tipsLabel.textColor     = [UIColor blackColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _tipsLabel;
}

@end
