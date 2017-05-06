//
//  Account.m
//  新浪微博sina
//
//  Created by zheng on 16/1/29.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "Account.h"

@implementation Account

#pragma mark 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_accessToken forKey:@"accessToken"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}

#pragma mark 解档的时候调用
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

@end
