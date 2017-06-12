//
//  SourceEditorCommand.m
//  XcodeExtensions
//
//  Created by Cain on 2017/6/12.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "SourceEditorCommand.h"
#import <Foundation/Foundation.h>

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {

    XCSourceTextBuffer *textBuffer = invocation.buffer;
    XCSourceTextRange *insertPointRange = textBuffer.selections[0];
    
    NSInteger startLine = insertPointRange.start.line;
    
    [textBuffer.lines insertObject:@"这是什么鬼👻" atIndex:startLine];
    
    completionHandler(nil);
}

@end
