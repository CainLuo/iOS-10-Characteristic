//
//  MessageStartController.h
//  iMessageSimpleProject
//
//  Created by Cain on 2017/6/10.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageStartController : UIViewController

@property (nonatomic, copy) void(^messageStartBloack)(UIButton *sender);

@end
