//
//  Account.h
//  新浪微博sina
//
//  Created by zheng on 16/1/29.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *uid;

@end
