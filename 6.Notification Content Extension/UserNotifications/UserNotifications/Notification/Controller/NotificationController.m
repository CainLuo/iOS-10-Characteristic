//
//  NotificationController.m
//  UserNotifications
//
//  Created by Cain on 2017/6/14.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "NotificationController.h"
#import "NotificationCell.h"
#import <UserNotifications/UserNotifications.h>

#define weakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define NORMAL_IDENTIFIER @"Normal"
#define IMAGE_IDENTIFIER  @"Image"
#define VIDEO_IDENTIFIER  @"Video"

typedef NS_ENUM(NSInteger, NotificationType) {
    NotificationNormalType = 0,
    NotificationImageType,
    NotificationVideoType
};

@interface NotificationController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation NotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray *)dataSource {
    
    NSDictionary *normalType = @{@"title":@"Normal Type",
                                 @"tag":@(NotificationNormalType),
                                 @"identifier":NORMAL_IDENTIFIER};
    
    NSDictionary *imageType = @{@"title":@"Image Type",
                                @"tag":@(NotificationImageType),
                                @"identifier":IMAGE_IDENTIFIER};

    NSDictionary *videoType = @{@"title":@"Video Type",
                                @"tag":@(NotificationVideoType),
                                @"identifier":VIDEO_IDENTIFIER};
    
    return @[normalType, imageType, videoType];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    NotificationCell *notificationCell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    
    if (!notificationCell) {
        
        notificationCell = [[NotificationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"NotificationCell"];
        
    }
    
    notificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [notificationCell configuraCellWithDictionary:self.dataSource[indexPath.row]];
    
    [notificationCell setNotificationTypeAction:^(UISwitch *sender){
        
        if (sender.on) {
            
            [self createReminderNotificationWithTag:sender.tag];
            
        } else {
            
            NSDictionary *dictionary = self.dataSource[indexPath.row];
            
            // 删除指定Identifier的Notification
            [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[dictionary[@"identifier"]]];
            
            NSLog(@"删除了%@通知", dictionary[@"identifier"]);
        }
    }];
    
    return notificationCell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

/**
 根据不同的Cell类型添加通知

 @param tag NotificationType
 */
- (void)createReminderNotificationWithTag:(NotificationType)tag {
    
    // 实例化Notification Content
    UNMutableNotificationContent *notificatinoContent = [[UNMutableNotificationContent alloc] init];
    
    // 设置Notification Content
    notificatinoContent.title = @"UserNotifications";
    notificatinoContent.sound = [UNNotificationSound defaultSound];
    notificatinoContent.categoryIdentifier = @"reminder";
    
    NSString *identifier = @"";
    
    switch (tag) {
        case NotificationNormalType:
            
            notificatinoContent.body = @"这是一条正常的通知.";
            
            identifier = NORMAL_IDENTIFIER;
            
            break;
        case NotificationImageType: {
            
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"01"
                                                                  ofType:@"jpg"];
            
            NSURL *imageURL = [NSURL fileURLWithPath:imagePath];
            
            // 设置一个添加了图片的Notification Attachment
            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttachment"
                                                                                                  URL:imageURL
                                                                                              options:nil
                                                                                                error:nil];
            notificatinoContent.attachments = @[attachment];
            notificatinoContent.body = @"这是一条带图片的通知";
            
            identifier = IMAGE_IDENTIFIER;
        }
            break;
        case NotificationVideoType: {
            
            NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"video"
                                                                  ofType:@"mp4"];
            
            NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
            
            // 设置一个添加了视频的Notification Attachment
            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"videoAttachment"
                                                                                                  URL:videoURL
                                                                                              options:nil
                                                                                                error:nil];
            notificatinoContent.attachments = @[attachment];
            notificatinoContent.body = @"这是一条带视频的通知";
            
            identifier = VIDEO_IDENTIFIER;
        }
            break;
        default:
            break;
    }
    
    NSLog(@"identifier: %@", identifier);
    
    [self retrieveNotification:^(UNNotificationRequest * notificationRequest) {
        
        if ([notificationRequest.identifier isEqualToString:identifier]) {
            
            NSLog(@"发现有相同的通知");
            
            return;
        }
        
        NSLog(@"没有相同的通知");

        // 设置通知的时间, 苹果爸爸限制最小是60秒提醒一次, 小于60秒都给你Crash掉
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60
                                                                                                        repeats:YES];
        
        // 创建Notification的请求
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                              content:notificatinoContent
                                                                              trigger:trigger];
        
        // 添加Notification的请求
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request
                                                               withCompletionHandler:^(NSError * _Nullable error) {
                                                                   
                                                                   if (error) {
                                                                       
                                                                       NSLog(@"发送通知失败: %@", error.localizedDescription);
                                                                   }
                                                               }];
    }];
}

/**
 判断通知的类型

 @param notificationRequest Block
 */
- (void)retrieveNotification:(void (^) (UNNotificationRequest *))notificationRequest {
    
    // 获取正在添加的Notification信息
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
     
            UNNotificationRequest *request = requests.firstObject;
            
            notificationRequest(request);
        });
    }];
}


@end
