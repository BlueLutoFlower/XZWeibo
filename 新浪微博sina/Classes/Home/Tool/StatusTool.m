//
//  StatusTool.m
//  新浪微博sina
//
//  Created by zheng on 16/2/1.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "StatusTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Status.h"

@implementation StatusTool

+ (void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure {
    [HttpTool getWithPath:@"2/statuses/home_timeline.json"
                   params:@{
                            @"count" : @5,
                            @"since_id" : @(sinceId),
                            @"max_id" : @(maxId)
                            } success:^(id JSON) {
                                if (success == nil) return;
                                NSMutableArray *statuses = [NSMutableArray array];
                                
                                NSArray *array = JSON[@"statuses"];
                                for (NSDictionary *dict in array) {
                                    Status *s = [[Status alloc] initWithDict:dict];
                                    [statuses addObject:s];
                                }
                                
                                success(statuses);
                                
                            } failure:^(NSError *error){
                                if (failure == nil) return ;
                                failure(error);
                            }];
}

@end
