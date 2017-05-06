//
//  StatusTool.h
//  新浪微博sina
//
//  Created by zheng on 16/2/1.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^StatusSuccessBlock)(NSArray *status);
typedef void(^StatusFailureBlock)(NSError *error);

@interface StatusTool : NSObject

+ (void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;
@end
