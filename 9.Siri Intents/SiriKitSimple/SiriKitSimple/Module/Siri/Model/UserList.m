//
//  UserList.m
//  SiriKitSimple
//
//  Created by Cain on 2017/6/19.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "UserList.h"

@implementation UserList

+ (NSArray<UserList *> *)userList {
    
    UserList *zhangsan   = [[UserList alloc] init];
    zhangsan.userName    = @"张三";
    zhangsan.userAddress = @"123@321.com";
    zhangsan.userIcon    = @"icon1";

    UserList *lisi   = [[UserList alloc] init];
    lisi.userName    = @"李四";
    lisi.userAddress = @"123@321.com";
    lisi.userIcon    = @"icon2";

    UserList *wangwu   = [[UserList alloc] init];
    wangwu.userName    = @"王五";
    wangwu.userAddress = @"123@321.com";
    wangwu.userIcon    = @"icon3";

    UserList *zhaoliu   = [[UserList alloc] init];
    zhaoliu.userName    = @"赵六";
    zhaoliu.userAddress = @"123@321.com";
    zhaoliu.userIcon    = @"icon4";

    return @[zhangsan, lisi, wangwu, zhaoliu];
}

+ (UserList *)checkUserWithName:(NSString *)name {
    
    if (!name.length) {
        return nil;
    }
  
    for (UserList *user in [self userList]) {
        
        if ([user.userName isEqualToString:name]) {
            
            return user;
        }
    }
    
    return nil;
}

@end
