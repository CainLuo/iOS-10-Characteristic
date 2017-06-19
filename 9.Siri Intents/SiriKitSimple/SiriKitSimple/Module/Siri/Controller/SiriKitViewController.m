//
//  SiriKitViewController.m
//  SiriKitSimple
//
//  Created by Cain on 2017/6/19.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SiriKitViewController.h"

@interface SiriKitViewController ()

@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation SiriKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tipsLabel];
}

- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                               self.view.frame.size.height / 2 - 100,
                                                               self.view.frame.size.width - 10,
                                                               200)];
        
        _tipsLabel.font          = [UIFont systemFontOfSize:25];
        _tipsLabel.text          = @"shift + option + command + H 呼叫Siri";
        _tipsLabel.textColor     = [UIColor blackColor];
        _tipsLabel.numberOfLines = 0;
    }
    
    return _tipsLabel;
}

@end
