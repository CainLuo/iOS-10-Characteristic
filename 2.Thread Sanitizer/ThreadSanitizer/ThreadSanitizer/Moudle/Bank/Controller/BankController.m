//
//  BankController.m
//  ThreadSanitizer
//
//  Created by Cain on 2017/6/11.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "BankController.h"
#import "BankView.h"
#import "Masonry.h"

@interface BankController ()

@property (nonatomic, strong) BankView *bankView;
@property (nonatomic, assign) NSInteger amount;

@end

@implementation BankController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self ts_addConstraintsWithSuperView];
}

- (BankView *)bankView {
    
    if (!_bankView) {
        
        __weak __typeof(&*self)weakSelf = self;
        
        _bankView = [[BankView alloc] init];
        
        [_bankView setSetBankBlock:^(UIButton *sender){
            
            [weakSelf setMoneyInTheBank];
        }];
        
        [_bankView setGetBankBlock:^(UIButton *sender){
            
            [weakSelf getMoneyOfBanek];
        }];
    }
    
    return _bankView;
}

/**
 存入银行的操作
 */
- (void)setMoneyInTheBank {
    
    NSString *amount = [NSString stringWithFormat:@"总额: ¥%ld", self.amount += 10];
    
    [self.bankView changeLabelContentWithString:amount];
}

/**
 从银行里取钱的操作
 */
- (void)getMoneyOfBanek {
    
    dispatch_async(dispatch_queue_create("com.threadsanitizer.ThreadSanitizer", nil), ^{
        
        if (self.amount <= 0) {
            NSLog(@"你都没钱啦, 怎么取?");
            
            return;
        }
        
        sleep(1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *amount = [NSString stringWithFormat:@"总额: ¥%ld", self.amount -= 10];

            [self.bankView changeLabelContentWithString:amount];
        });
    });
}

- (void)ts_addConstraintsWithSuperView {
    
    [self.view addSubview:self.bankView];
    
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.edges;
    }];
}

@end
