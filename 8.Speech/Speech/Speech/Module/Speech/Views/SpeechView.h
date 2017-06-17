//
//  SpeechView.h
//  Speech
//
//  Created by Cain on 2017/6/16.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeechView : UIView

@property (nonatomic, strong, readonly) UIView *squareView;

@property (nonatomic, copy) void(^speechViewBlock)(UIButton *sender);

- (void)changeLabelTextWithString:(NSString *)string;

@end
