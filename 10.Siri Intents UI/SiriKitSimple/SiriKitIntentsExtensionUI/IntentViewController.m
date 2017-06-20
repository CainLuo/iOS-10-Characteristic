//
//  IntentViewController.m
//  SiriKitIntentsExtensionUI
//
//  Created by Cain on 2017/6/19.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "IntentViewController.h"
#import "UserList.h"
#import <Intents/Intents.h>

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

@interface IntentViewController () <INUIHostedViewSiriProviding>

@property (weak, nonatomic) IBOutlet UIImageView *userImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *messageBackgroundImage;

@property (weak, nonatomic) IBOutlet UIImageView *toUserImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;

@end

@implementation IntentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - INUIHostedViewControlling

// Prepare your view controller for the interaction to handle.
- (void)configureWithInteraction:(INInteraction *)interaction
                         context:(INUIHostedViewContext)context
                      completion:(void (^)(CGSize))completion {
    // Do configuration here, including preparing views and calculating a desired size for presentation.
    
    // 截取发送消息的Intent
    INSendMessageIntent *intent = (INSendMessageIntent *)(interaction.intent);
    
    // 获取用户信息
    NSString *name = [[intent.recipients lastObject] displayName];
    NSString *content = intent.content;
    NSString *icon = [UserList checkUserWithName:name].userIcon;

    // 展示自己与接收人的头像
    self.userImageIcon.image = [UIImage imageNamed:@"icon3"];
    self.toUserImageIcon.image = [UIImage imageNamed:icon];
    
    // 改变标题
    self.sectionTitleLabel.text = [NSString stringWithFormat:@"与\"%@\"对话", name];
    
    // 发送的消息内容
    self.messageContentLabel.text = content;
    
    // 隐藏或显示控件
    self.sectionTitleLabel.hidden      = !name.length;
    self.messageContentLabel.hidden    = !content.length;
    self.messageBackgroundImage.hidden = !content.length;
    self.toUserImageIcon.hidden        = !self.toUserImageIcon.image;
    
    if (completion) {
        completion(CGSizeMake([self desiredSize].width, 150));
    }
}

- (CGSize)desiredSize {
    return [self extensionContext].hostedViewMaximumAllowedSize;
}

#pragma mark - INUIHostedViewSiriProviding
//- (BOOL)displaysMessage {
//    return YES;
//}

@end
