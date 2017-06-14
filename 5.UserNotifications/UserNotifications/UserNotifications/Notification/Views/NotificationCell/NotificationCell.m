//
//  NotificationCell.m
//  UserNotifications
//
//  Created by Cain on 2017/6/14.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "NotificationCell.h"

@interface NotificationCell()

@property (nonatomic, strong) UISwitch *notificationSwitch;

@end

@implementation NotificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self addSubview:self.notificationSwitch];
    }
    
    return self;
}

- (void)configuraCellWithDictionary:(NSDictionary *)dictionary {
    
    if (dictionary) {
        
        self.textLabel.text = dictionary[@"title"];
        self.notificationSwitch.tag = [dictionary[@"tag"] integerValue];
    }
}

- (UISwitch *)notificationSwitch {
    
    if (!_notificationSwitch) {
        
        _notificationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 100,
                                                                         20,
                                                                         100,
                                                                         80)];
        
        _notificationSwitch.on = NO;
        
        [_notificationSwitch addTarget:self
                                action:@selector(notificationSwitchAction:)
                      forControlEvents:UIControlEventValueChanged];
    }
    
    return _notificationSwitch;
}

- (void)notificationSwitchAction:(UISwitch *)sender {
    
    if (self.NotificationTypeAction) {
        self.NotificationTypeAction(sender);
    }
}

@end
