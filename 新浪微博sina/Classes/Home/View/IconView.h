//
//  IconView.h
//  新浪微博sina
//
//  Created by zheng on 16/2/2.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kIconTypeSmall,
    kIconTypeDefault,
    kIconTypeBig
} IconType;

@class User;
@interface IconView : UIView
@property (nonatomic, strong) User *user;
@property (nonatomic, assign) IconType type;

- (void)setUser:(User *)user type:(IconType)type;

+ (CGSize)iconSizeWithType:(IconType)type;

@end
