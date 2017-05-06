//
//  Status.h
//  新浪微博sina
//
//  Created by zheng on 16/2/1.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface Status : NSObject

@property (nonatomic, assign) long long ID;
@property (nonatomic, copy) NSString *text; // 微博内容
@property (nonatomic, strong) User *user; // 微博用户
@property (nonatomic, strong) NSArray *picUrls; // 微博配图
@property (nonatomic, strong) Status *retweetedStatus; // 被转发的微博
@property (nonatomic, copy) NSString *createdAt; // 微博创建时间
@property (nonatomic, assign) int repostsCount; // 转发数
@property (nonatomic, assign) int commentsCount; // 评论数
@property (nonatomic, assign) int attitudesCount; // 表态数(被赞)
@property (nonatomic, copy) NSString *source; // 微博来源

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
