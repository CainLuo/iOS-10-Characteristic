//
//  MeasurementController.m
//  Measurement
//
//  Created by Cain on 2017/6/15.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "MeasurementController.h"
#import "MeasurementView.h"

@interface MeasurementController ()

@property (nonatomic, strong) MeasurementView *measurementView;

@end

@implementation MeasurementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.measurementView];
    
    // 初始化一个秒数的基数
    NSMeasurement *seconds = [[NSMeasurement alloc] initWithDoubleValue:666
                                                                       unit:NSUnitDuration.seconds];
    
    // 转换为分钟
    NSMeasurement *minutes = [seconds measurementByConvertingToUnit:NSUnitDuration.minutes];
    
    // 转换为小时
    NSMeasurement *hours   = [seconds measurementByConvertingToUnit:NSUnitDuration.hours];

    NSString *secondsString = [NSString stringWithFormat:@"%.2f 秒", seconds.doubleValue];
    NSString *minutesString = [NSString stringWithFormat:@"%.2f 分钟", minutes.doubleValue];
    NSString *hoursString   = [NSString stringWithFormat:@"%.2f 小时", hours.doubleValue];
    
    [self.measurementView setSeconds:secondsString
                             minutes:minutesString
                               hours:hoursString];
}

- (MeasurementView *)measurementView {
    
    if (!_measurementView) {
        
        _measurementView = [[MeasurementView alloc] initWithFrame:self.view.frame];
        
        _measurementView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _measurementView;
}

@end
