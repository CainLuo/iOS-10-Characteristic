//
//  MessageChangeController.h
//  iMessageSimpleProject
//
//  Created by Cain on 2017/6/10.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageChangeController : UIViewController

@property (nonatomic, copy) void(^messageChangeBloack)(UIButton *sender);

@end
