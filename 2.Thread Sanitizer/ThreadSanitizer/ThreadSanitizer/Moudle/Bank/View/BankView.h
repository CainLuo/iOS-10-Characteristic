//
//  BankView.h
//  ThreadSanitizer
//
//  Created by Cain on 2017/6/11.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BankButtonType) {
    GetType = 0,
    SetType
};

@interface BankView : UIView

/**
 按钮的点击事件回调
 */
@property (nonatomic, copy) void(^setBankBlock)(UIButton *sender);
@property (nonatomic, copy) void(^getBankBlock)(UIButton *sender);


/**
 根据不同的类型来修改总额

 @param string NSString
 */
- (void)changeLabelContentWithString:(NSString *)string;

@end
