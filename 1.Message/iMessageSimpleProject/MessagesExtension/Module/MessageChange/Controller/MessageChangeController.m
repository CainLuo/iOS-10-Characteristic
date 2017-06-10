//
//  MessageChangeController.m
//  iMessageSimpleProject
//
//  Created by Cain on 2017/6/10.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "MessageChangeController.h"
#import "Masonry.h"

@interface MessageChangeController ()

@property (nonatomic, strong) UIButton *finishButton;

@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation MessageChangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.finishButton];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.centerY.centerX;
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.centerX;
        make.bottom.equalTo(self.finishButton.mas_top).offset(-20);
    }];
}

#pragma mark - Start Button
- (UIButton *)finishButton {
    
    if (!_finishButton) {
        
        _finishButton = [[UIButton alloc] init];
        
        [_finishButton setBackgroundColor:[UIColor whiteColor]];
        [_finishButton setTitle:@"结束使用插件"
                       forState:UIControlStateNormal];
        [_finishButton setTitleColor:[UIColor blackColor]
                            forState:UIControlStateNormal];
        [_finishButton addTarget:self
                          action:@selector(starButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _finishButton;
}

- (void)starButtonAction:(UIButton *)sender {
    
    if (self.messageChangeBloack) {
        self.messageChangeBloack(sender);
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
