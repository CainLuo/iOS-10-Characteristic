//
//  UIImage+MessageImage.m
//  iMessageSimpleProject
//
//  Created by Cain on 2017/6/10.
//  Copyright © 2017年 Cain. All rights reserved.
//

#import "UIImage+MessageImage.h"

@implementation UIImage (MessageImage)

+ (UIImage *)ms_getImageForView:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageRet;
}

@end
