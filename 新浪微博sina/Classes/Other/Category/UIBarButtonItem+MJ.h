//
//  UIBarButtonItem+MJ.h
//  sina
//
//  Created by zheng on 16/1/8.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MJ)

+(instancetype)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;

-(instancetype)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
@end
