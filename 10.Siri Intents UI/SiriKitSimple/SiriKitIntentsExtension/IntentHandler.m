//
//  IntentHandler.m
//  SiriKitIntentsExtension
//
//  Created by Cain on 2017/6/19.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "IntentHandler.h"
#import "NSString+PinYin.h"
#import "UserList.h"

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

@interface IntentHandler () <INSendMessageIntentHandling, INSearchForMessagesIntentHandling, INSetMessageAttributeIntentHandling>

@end

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self;
}

#pragma mark - INSendMessageIntentHandling

// Implement resolution methods to provide additional information about your intent (optional).
- (void)resolveRecipientsForSendMessage:(INSendMessageIntent *)intent
                         withCompletion:(void (^)(NSArray<INPersonResolutionResult *> *resolutionResults))completion {
    
    NSArray<INPerson *> *recipients = intent.recipients;
    
    // If no recipients were provided we'll need to prompt for a value.
    if (recipients.count == 0) {
        
        completion(@[[INPersonResolutionResult needsValue]]);
        
        return;
    }
    
    NSMutableArray<INPersonResolutionResult *> *resolutionResults = [NSMutableArray array];
    
    // 遍历待匹配选项
    for (INPerson *recipient in recipients) {
        
        // Implement your contact matching logic here to create an array of matching contacts
        NSMutableArray<INPerson *> *matchingContacts = [NSMutableArray array];
        
        // 待匹配的名称
        NSString *recipientName = recipient.displayName;
        NSString *recipientNamePinYin = [recipientName cl_PinYin];
        
        // 精确的匹配到列表里的用户
        UserList *user = [UserList checkUserWithName:recipientName];
        
        if (user) {
            
            NSLog(@"匹配到精确用户:%@", user);
    
            // 创建一个匹配成功的用户
            INPersonHandle *personHandle = [[INPersonHandle alloc] initWithValue:user.userAddress
                                                                            type:INPersonHandleTypeEmailAddress];
            INImage *iconImage = [INImage imageNamed:user.userIcon];
            
            INPerson *person = [[INPerson alloc] initWithPersonHandle:personHandle
                                                       nameComponents:nil
                                                          displayName:recipientName
                                                                image:iconImage
                                                    contactIdentifier:nil
                                                     customIdentifier:nil
                                                              aliases:nil
                                                       suggestionType:INPersonSuggestionTypeSocialProfile];
            
            // 把匹配成功的用户记录下来
            [matchingContacts addObject:person];
        }
        
        // 如果没有精确匹配到用户, 则用模糊匹配
        if (matchingContacts.count == 0) {
            
            NSLog(@"没有匹配到精确用户:%@", user);

            for (UserList *user in [UserList userList]) {
                
                // 匹配用户的名称
                NSString *userName = user.userName;
                NSString *userNamePinYin = [userName cl_PinYin];
                
                if ([recipientName containsString:userName] || [recipientNamePinYin containsString:userNamePinYin]) {
                    
                    //  创建一个匹配成功的用户
                    INPersonHandle *personHandle = [[INPersonHandle alloc] initWithValue:user.userAddress
                                                                                    type:INPersonHandleTypeEmailAddress];
                    
                    INImage *iconImage = [INImage imageNamed:user.userIcon];
                    
                    INPerson *person = [[INPerson alloc] initWithPersonHandle:personHandle
                                                               nameComponents:nil
                                                                  displayName:userName
                                                                        image:iconImage
                                                            contactIdentifier:nil
                                                             customIdentifier:nil
                                                                      aliases:nil
                                                               suggestionType:INPersonSuggestionTypeSocialProfile];
                    
                    //  记录匹配的用户
                    [matchingContacts addObject:person];
                }
            }
        }
        
        NSLog(@"用户列表: %@", matchingContacts);
        
        if (matchingContacts.count > 1) {
            
            // We need Siri's help to ask user to pick one from the matches.
            [resolutionResults addObject:[INPersonResolutionResult disambiguationWithPeopleToDisambiguate:matchingContacts]];

        } else if (matchingContacts.count == 1) {
            
            // We have exactly one matching contact
            [resolutionResults addObject:[INPersonResolutionResult successWithResolvedPerson:recipient]];
        } else {
            
            // We have no contacts matching the description provided
            [resolutionResults addObject:[INPersonResolutionResult unsupported]];
        }
    }
    completion(resolutionResults);
}

- (void)resolveContentForSendMessage:(INSendMessageIntent *)intent withCompletion:(void (^)(INStringResolutionResult *resolutionResult))completion {
    NSString *text = intent.content;
    if (text && ![text isEqualToString:@""]) {
        completion([INStringResolutionResult successWithResolvedString:text]);
    } else {
        completion([INStringResolutionResult needsValue]);
    }
}

// Once resolution is completed, perform validation on the intent and provide confirmation (optional).

- (void)confirmSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Verify user is authenticated and your app is ready to send a message.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeReady userActivity:userActivity];
    completion(response);
}

// Handle the completed intent (required).

- (void)handleSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Implement your application logic to send a message here.
    
    NSString *email = [intent.recipients lastObject].personHandle.value;
    NSString *content = intent.content;
    
    NSLog(@"发送邮件\"%@\"给%@", content, email);
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}

// Implement handlers for each intent you wish to handle.  As an example for messages, you may wish to also handle searchForMessages and setMessageAttributes.

#pragma mark - INSearchForMessagesIntentHandling

- (void)handleSearchForMessages:(INSearchForMessagesIntent *)intent completion:(void (^)(INSearchForMessagesIntentResponse *response))completion {
    // Implement your application logic to find a message that matches the information in the intent.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSearchForMessagesIntent class])];
    INSearchForMessagesIntentResponse *response = [[INSearchForMessagesIntentResponse alloc] initWithCode:INSearchForMessagesIntentResponseCodeSuccess userActivity:userActivity];
    // Initialize with found message's attributes
    response.messages = @[[[INMessage alloc]
        initWithIdentifier:@"identifier"
        content:@"I am so excited about SiriKit!"
        dateSent:[NSDate date]
        sender:[[INPerson alloc] initWithPersonHandle:[[INPersonHandle alloc] initWithValue:@"sarah@example.com" type:INPersonHandleTypeEmailAddress] nameComponents:nil displayName:@"Sarah" image:nil contactIdentifier:nil customIdentifier:nil]
        recipients:@[[[INPerson alloc] initWithPersonHandle:[[INPersonHandle alloc] initWithValue:@"+1-415-555-5555" type:INPersonHandleTypePhoneNumber] nameComponents:nil displayName:@"John" image:nil contactIdentifier:nil customIdentifier:nil]]
    ]];
    completion(response);
}

#pragma mark - INSetMessageAttributeIntentHandling

- (void)handleSetMessageAttribute:(INSetMessageAttributeIntent *)intent completion:(void (^)(INSetMessageAttributeIntentResponse *response))completion {
    // Implement your application logic to set the message attribute here.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSetMessageAttributeIntent class])];
    INSetMessageAttributeIntentResponse *response = [[INSetMessageAttributeIntentResponse alloc] initWithCode:INSetMessageAttributeIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}

@end
