//
//  AnimationController.m
//  UIViewPropertyAnimator
//
//  Created by Cain on 2017/6/12.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "AnimationController.h"
#import "BasicsView.h"

#define weakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;


@interface AnimationController ()

@property (nonatomic, strong) BasicsView *basicsView;

@property (nonatomic, strong) UIViewPropertyAnimator *propertyAnimator;

@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.basicsView];
    
//    [self viewAnimationCurveEaseOut];
//    [self addSliderWithSuperView];
//    [self viewAnimationCurveEaseInOut];
//    [self springTimingParameters];
    [self cubicTimingParameters];
}

/**
 基础动画
 */
- (void)viewAnimationCurveEaseOut {
    
    weakSelf(weakSelf);
    
    self.propertyAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:1
                                                                       curve:UIViewAnimationCurveEaseOut
                                                                  animations:^{
                                                                                         
                                                                      [self.basicsView moveViewToBottmRight];
                                                                                         
                                                                  }];
    
    [self.propertyAnimator startAnimation];
    
    // 添加多一个渐渐消失的动画
    [self.propertyAnimator addAnimations:^{
        weakSelf.basicsView.alpha = 0;
    }];
    
    [self.propertyAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        
        NSLog(@"动画结束咯");
    }];
    
    [self.propertyAnimator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        
        switch (finalPosition) {
                
            case UIViewAnimatingPositionStart:
                
                NSLog(@"动画开始了");
                
                break;
                
            case UIViewAnimatingPositionCurrent:
                
                NSLog(@"动画结束咯");

                break;
                
            case UIViewAnimatingPositionEnd:
                
                NSLog(@"正在执行动画");

                break;
            default:
                break;
        }
    }];
}

/**
 添加UISlider的拖拽动画
 */
- (void)addSliderWithSuperView {
    
    self.propertyAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:5
                                                                       curve:UIViewAnimationCurveEaseIn
                                                                  animations:^{
                                                                                         
                                                                      [self.basicsView moveViewToBottmRight];
                                                                  }];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    
    [slider addTarget:self
               action:@selector(sliderValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    
    [self.basicsView addSubview:slider];
}

/**
 UISlider的响应方法

 @param slider UISlider
 */
- (void)sliderValueChanged:(UISlider *)slider {
    
    self.propertyAnimator.fractionComplete = slider.value;
}

/**
 反向动画
 */
- (void)viewAnimationCurveEaseInOut {
    
    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - 100, 100, 200, 50)];
    
    [resetButton setTitleColor:[UIColor blackColor]
                      forState:UIControlStateNormal];
    [resetButton setTitle:@"开始反向动画"
                 forState:UIControlStateNormal];
    [resetButton addTarget:self
                    action:@selector(resetButtonAction)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:resetButton];
    
    self.propertyAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:3
                                                                       curve:UIViewAnimationCurveEaseInOut
                                                                  animations:^{
                                                                      
                                                                      [self.basicsView moveViewToBottmRight];
                                                                  }];
    [self.propertyAnimator startAnimation];
}

/**
 按钮点击事件
 */
- (void)resetButtonAction {
    
    self.propertyAnimator.reversed = YES;
}

/**
 UISpringTimingParameters 动画
 */
- (void)springTimingParameters {
    
    weakSelf(weakSelf);

    UISpringTimingParameters *springTimingParameters = [[UISpringTimingParameters alloc] initWithDampingRatio:0.3
                                                                                              initialVelocity:CGVectorMake(0, 0)];
    
    self.propertyAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:4
                                                            timingParameters:springTimingParameters];
    
    [self.propertyAnimator addAnimations:^{
        
                            [weakSelf.basicsView moveViewToBottmRight];
    } delayFactor:3.0];
    
    [self.propertyAnimator startAnimation];
}


/**
 UICubicTimingParameters 动画
 */
- (void)cubicTimingParameters {
    
    weakSelf(weakSelf);

    UICubicTimingParameters *cubicTimingParameters = [[UICubicTimingParameters alloc] initWithControlPoint1:CGPointMake(0.05, 0.95)
                                                                                              controlPoint2:CGPointMake(0.15, 0.95)];
    
    self.propertyAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:4
                                                            timingParameters:cubicTimingParameters];
    
    
    [self.propertyAnimator addAnimations:^{
        
        [weakSelf.basicsView moveViewToBottmRight];
    } delayFactor:0.25];
    
    [self.propertyAnimator startAnimation];
}

- (BasicsView *)basicsView {
    
    if (!_basicsView) {
        
        _basicsView = [[BasicsView alloc] initWithFrame:self.view.frame];
    }
    
    return _basicsView;
}

@end
