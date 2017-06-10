//
//  MessagesViewController.m
//  MessagesExtension
//
//  Created by Cain on 2017/6/9.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessageStartController.h"
#import "MessageFinishController.h"
#import "MessageChangeController.h"
#import "Masonry.h"
#import "UIImage+MessageImage.h"

@interface MessagesViewController ()

@property (nonatomic, strong) UIViewController *childViewController;

@end

@implementation MessagesViewController

- (void)willBecomeActiveWithConversation:(MSConversation *)conversation {
    
    [self configureChildViewControllerWithPresentationStyle:self.presentationStyle
                                               conversation:conversation];
}

-(void)willTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {

    [self configureChildViewControllerWithPresentationStyle:presentationStyle
                                               conversation:self.activeConversation];
}

/**
 Configure ChildController

 @param presentationStyle MSMessagesAppPresentationStyle
 @param conversation MSConversation
 */
- (void)configureChildViewControllerWithPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle
                                             conversation:(MSConversation *)conversation {
    
    // 清除所有的自控制器
    for (UIViewController *childController in self.childViewControllers) {
        
        [childController willMoveToParentViewController:nil];
        [childController.view removeFromSuperview];
        [childController removeFromParentViewController];
    }
    
    switch (presentationStyle) {
        case MSMessagesAppPresentationStyleCompact:
            
            self.childViewController = [self createMessageStartController];
            
            break;
        case MSMessagesAppPresentationStyleExpanded:{
            
            MSMessage *message = conversation.selectedMessage;
            
            if (message) {
                
                self.childViewController = [self createChangeControllerWithConversation:conversation];

            } else {
                self.childViewController = [self createFinishControllerWithConversation:conversation];
            }
        }
            break;
        default:
            break;
    }
    
    // 添加子控制器
    [self addChildViewController:self.childViewController];
    
    [self.view addSubview:self.childViewController.view];
    
    [self.childViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.edges;
    }];
    
    [self.childViewController didMoveToParentViewController:self];
}

/**
 Configure Message Start Controller

 @return UIViewController
 */
- (UIViewController *)createMessageStartController {
    
    MessageStartController *childController = [[MessageStartController alloc] init];
    
    [childController setMessageStartBloack:^(UIButton *sender){
        
        [self requestPresentationStyle:MSMessagesAppPresentationStyleExpanded];
    }];
    
    return childController;
}

/**
 Configure Message Finish Controller
 
 @return UIViewController
 */
- (UIViewController *)createFinishControllerWithConversation:(MSConversation *)conversation {
    
    MessageFinishController *finishController = [[MessageFinishController alloc] init];
    
    [finishController setMessageFinishBloack:^(UIButton *sender){
        
        MSSession *session = [[MSSession alloc] init];
        
        NSString *player = [NSString stringWithFormat:@"%@ - 是否要发送这条内容?", conversation.localParticipantIdentifier];
        
        [self insertMessageWithCaption:player
                               session:session
                                 image:[UIImage ms_getImageForView:self.view]
                          conversation:conversation];
        
        [self dismiss];
    }];
    
    return finishController;
}

/**
 Configure Message Change Controller
 
 @return UIViewController
 */
- (UIViewController *)createChangeControllerWithConversation:(MSConversation *)conversation {
    
    MessageChangeController *changeViewController = [[MessageChangeController alloc] init];
    
    [changeViewController setMessageChangeBloack:^(UIButton *sender){
        
        MSMessage *message = conversation.selectedMessage;
        
        if (message) {
            
            MSSession *session = [message session];
            
            NSString *player = [NSString stringWithFormat:@"%@ - 是否要发送更改后的内容?", conversation.localParticipantIdentifier];
            
            [self insertMessageWithCaption:player
                                   session:session
                                     image:[UIImage ms_getImageForView:self.view]
                              conversation:conversation];
        }
        
        [self dismiss];
    }];
    
    return changeViewController;
}

/**
 把内容插入到Message中

 @param caption NSString
 @param session MSSession
 @param image UIImage
 @param conversation MSConversation
 */
- (void)insertMessageWithCaption:(NSString *)caption
                         session:(MSSession *)session
                           image:(UIImage *)image
                    conversation:(MSConversation *)conversation {
    
    MSMessage *message = [[MSMessage alloc] initWithSession:session];
    MSMessageTemplateLayout *templateLayout = [[MSMessageTemplateLayout alloc] init];
    
    templateLayout.caption = caption;
    templateLayout.image = image;
    
    message.layout = templateLayout;
    message.URL = [NSURL URLWithString:@"http://www.baidu.com"];
    
    [conversation insertMessage:message
              completionHandler:nil];
}

@end
