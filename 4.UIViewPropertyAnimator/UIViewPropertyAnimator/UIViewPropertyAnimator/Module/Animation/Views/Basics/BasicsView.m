//
//  BasicsView.m
//  UIViewPropertyAnimator
//
//  Created by Cain on 2017/6/13.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "BasicsView.h"

@interface BasicsView()

@property (nonatomic, strong) UIView *animateView;

@end

@implementation BasicsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
                
        [self addSubview:self.animateView];
        
        self.animateView.center = CGPointMake(CGRectGetMinX(frame) + CGRectGetMidX(self.animateView.bounds),
                                              CGRectGetMaxY(frame) - CGRectGetMidY(self.animateView.bounds));
    }
    
    return self;
}

- (UIView *)animateView {
    
    if (!_animateView) {
        
        _animateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        _animateView.backgroundColor = [UIColor redColor];
    }
    
    return _animateView;
}

- (void)moveViewToBottmRight {
    
    self.animateView.center = CGPointMake(CGRectGetMaxX(self.frame) - CGRectGetMidX(self.animateView.bounds),
                                          CGRectGetMaxY(self.frame) - CGRectGetMidY(self.animateView.bounds));
}


@end
