//
//  MeasurementView.m
//  Measurement
//
//  Created by Cain on 2017/6/15.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "MeasurementView.h"

@interface MeasurementView ()

@property (nonatomic, strong) UILabel *secondsLabel;
@property (nonatomic, strong) UILabel *minutesLabel;
@property (nonatomic, strong) UILabel *hoursLabel;

@end

@implementation MeasurementView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.secondsLabel];
        [self addSubview:self.minutesLabel];
        [self addSubview:self.hoursLabel];
    }
    
    return self;
}

- (void)setSeconds:(NSString *)seconds
           minutes:(NSString *)minutes
             hours:(NSString *)hours {
    
    self.secondsLabel.text = seconds;
    self.minutesLabel.text = minutes;
    self.hoursLabel.text   = hours;
}

- (UILabel *)secondsLabel {
    
    if (!_secondsLabel) {
        
        _secondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                  100,
                                                                  self.frame.size.width,
                                                                  50)];
        _secondsLabel.textColor     = [UIColor blackColor];
        _secondsLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _secondsLabel;
}

- (UILabel *)minutesLabel {
    
    if (!_minutesLabel) {
        
        _minutesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                  150,
                                                                  self.frame.size.width,
                                                                  50)];
        
        _minutesLabel.textColor     = [UIColor blackColor];
        _minutesLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _minutesLabel;
}

- (UILabel *)hoursLabel {
    
    if (!_hoursLabel) {
        
        _hoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                200,
                                                                self.frame.size.width,
                                                                50)];
        
        _hoursLabel.textColor     = [UIColor blackColor];
        _hoursLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _hoursLabel;
}

@end
