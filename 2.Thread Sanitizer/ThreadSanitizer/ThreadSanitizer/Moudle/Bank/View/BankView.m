//
//  BankView.m
//  ThreadSanitizer
//
//  Created by Cain on 2017/6/11.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "BankView.h"
#import "Masonry.h"

@interface BankView()

@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UIButton *setButton;
@property (nonatomic, strong) UIButton *getButton;

@end

@implementation BankView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self ts_addConstraintsWithSuperView];
    }
    
    return self;
}

- (void)changeLabelContentWithString:(NSString *)string {
    
    if (string) {
        
        self.amountLabel.text = string;
    }
}

- (UILabel *)amountLabel {
    
    if (!_amountLabel) {
        
        _amountLabel                 = [[UILabel alloc] init];
        _amountLabel.text            = @"总额: ¥0";
        _amountLabel.font            = [UIFont systemFontOfSize:35];
        _amountLabel.textColor       = [UIColor blackColor];
        _amountLabel.textAlignment   = NSTextAlignmentCenter;
    }
    
    return _amountLabel;
}

- (UIButton *)setButton {
    
    if (!_setButton) {
        
        _setButton                 = [[UIButton alloc] init];
        _setButton.tag             = SetType;
        _setButton.backgroundColor = [UIColor cyanColor];
        
        [_setButton setTitleColor:[UIColor blackColor]
                         forState:UIControlStateNormal];
        [_setButton setTitle:@"存入10块钱"
                    forState:UIControlStateNormal];
        [_setButton addTarget:self
                       action:@selector(buttonActions:)
             forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _setButton;
}

- (UIButton *)getButton {
    
    if (!_getButton) {
        
        _getButton                 = [[UIButton alloc] init];
        _getButton.tag             = GetType;
        _getButton.backgroundColor = [UIColor greenColor];
        
        [_getButton setTitleColor:[UIColor blackColor]
                         forState:UIControlStateNormal];
        [_getButton setTitle:@"取出10块钱"
                    forState:UIControlStateNormal];
        [_getButton addTarget:self
                       action:@selector(buttonActions:)
             forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _getButton;
}

- (void)buttonActions:(UIButton *)sender {
    
    switch (sender.tag) {
        case GetType:
            
            if (self.getBankBlock) {
                
                self.getBankBlock(sender);
            }
            break;
        case SetType:
            
            if (self.setBankBlock) {
                
                self.setBankBlock(sender);
            }
            break;
        default:
            break;
    }
}

- (void)ts_addConstraintsWithSuperView {
    
    [self addSubview:self.amountLabel];
    [self addSubview:self.setButton];
    [self addSubview:self.getButton];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.left.right.centerX;
        make.centerY.equalTo(self.mas_centerY).dividedBy(2);
    }];
    
    [self.setButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.centerY.centerX;
        make.width.equalTo(self.mas_width).dividedBy(2);
    }];

    [self.getButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.width.height.equalTo(self.setButton);
        make.top.equalTo(self.setButton.mas_bottom).offset(20);
    }];
}

@end
