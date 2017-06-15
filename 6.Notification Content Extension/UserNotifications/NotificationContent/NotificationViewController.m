//
//  NotificationViewController.m
//  NotificationContent
//
//  Created by Cain on 2017/6/15.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    
    [self addShakeAnimation];
}

- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response
                     completionHandler:(void (^)(UNNotificationContentExtensionResponseOption))completion {
    
    if ([response.actionIdentifier isEqualToString:@"cancel"]) {
        
        UNNotificationRequest *request = response.notification.request;
        
        NSArray *identifiers = @[request.identifier];
        
        // 根据标识符删除等待通知
        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:identifiers];
        
        // 根据标识符删除发送通知
        [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:identifiers];
        
        self.label.text = @"点击了取消按钮";
        
        // 删除动画效果
        [self removeShakeAnimation];
        
        // 不隐藏通知页面
        completion(UNNotificationContentExtensionResponseOptionDoNotDismiss);
        
    } else {
        
        // 隐藏通知页面
        completion(UNNotificationContentExtensionResponseOptionDismiss);
    }
}

- (void)addShakeAnimation {
    
    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animation];

    frameAnimation.keyPath        = @"transform.translation.x";
    frameAnimation.duration       = 1;
    frameAnimation.repeatCount    = MAXFLOAT;
    frameAnimation.values         = @[@-20.0, @20.0, @-20.0, @20.0, @-10.0, @10.0, @-5.0, @5.0, @0.0];
    frameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.view.layer addAnimation:frameAnimation
                           forKey:@"shake"];
}

- (void)removeShakeAnimation {
    
    [self.view.layer removeAnimationForKey:@"shake"];
}

@end
