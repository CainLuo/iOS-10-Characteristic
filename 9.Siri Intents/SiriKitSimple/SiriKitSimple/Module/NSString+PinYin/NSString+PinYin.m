//
//  NSString+PinYin.m
//  SiriKitSimple
//
//  Created by Cain on 2017/6/19.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "NSString+PinYin.h"

@implementation NSString (PinYin)

- (NSString *)cl_PinYin {
    
    NSMutableString *pinyin = [self mutableCopy];
    
    CFStringTransform((__bridge CFMutableStringRef)pinyin,
                      NULL,
                      kCFStringTransformMandarinLatin,
                      NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin,
                      NULL,
                      kCFStringTransformStripCombiningMarks,
                      NO);
    
    return pinyin;
}

@end
