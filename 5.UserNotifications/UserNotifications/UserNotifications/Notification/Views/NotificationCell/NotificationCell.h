//
//  NotificationCell.h
//  UserNotifications
//
//  Created by Cain on 2017/6/14.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell

@property (nonatomic, copy) void(^NotificationTypeAction)(UISwitch *sender);

- (void)configuraCellWithDictionary:(NSDictionary *)dictionary;

@end
