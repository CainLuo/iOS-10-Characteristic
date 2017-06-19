//
//  UserList.h
//  SiriKitSimple
//
//  Created by Cain on 2017/6/19.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserList : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userAddress;
@property (nonatomic, copy) NSString *userIcon;

/**
 获取用户列表

 @return NSArray
 */
+ (NSArray<UserList *> *)userList;

/**
 检查用户名是否存在

 @param name NSString
 @return UserList
 */
+ (UserList *)checkUserWithName:(NSString *)name;

@end
