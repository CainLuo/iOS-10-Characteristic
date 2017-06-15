//
//  AppDelegate.m
//  UserNotifications
//
//  Created by Cain on 2017/6/14.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "AppDelegate.h"
#import "NotificationController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (UIWindow *)window {
    
    if (!_window) {
        
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _window.backgroundColor = [UIColor whiteColor];
    }
    
    return _window;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = [[NotificationController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    // 设置Notification的代理对象
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    // 询问用户是否同意App的消息通知
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionSound | UNAuthorizationOptionAlert
                                                                        completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                                            
                                                                            if (granted) {
                                                                                NSLog(@"用户同意发送通知咯");
                                                                            }
        
    }];
    
    [self addCategoryWithNotification];
    
    return YES;
}

/**
 添加Category
 */
- (void)addCategoryWithNotification {
    
    // 设置Notification的Action Button
    UNNotificationAction *cancel = [UNNotificationAction actionWithIdentifier:@"cancel"
                                                                        title:@"Cancel"
                                                                      options:UNNotificationActionOptionForeground];
    
    // 设置Notification的Category
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"reminder"
                                                                              actions:@[cancel]
                                                                    intentIdentifiers:@[]
                                                                              options:UNNotificationCategoryOptionCustomDismissAction];
    NSSet *categorySet = [NSSet setWithObject:category];
    
    // 设置Notification的Categories
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categorySet];
}

#pragma mark - UserNotificationCenterDelegate方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    
    if ([response.actionIdentifier  isEqual: @"cancel"]) {
        
        UNNotificationRequest *request = response.notification.request;
        
        NSLog(@"删除了通知的identifier: %@", request.identifier);
        
        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[request.identifier]];
    }
    
    completionHandler();
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    completionHandler(UNNotificationPresentationOptionAlert);
}

@end
