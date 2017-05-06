//
//  UIImage+MJ.h
//  sina
//
//  Created by zheng on 15/12/23.
//  Copyright (c) 2015年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MJ)

#pragma mark 加载全屏的图片
+ (UIImage *)fullscrennImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

@end
