//
//  HttpTool.m
//  新浪微博sina
//
//  Created by zheng on 16/1/29.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "Weibocfg.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"

@implementation HttpTool

+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method{
    
    // 1.创建post请求
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kBaseURL]];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    // 拼接传进来的参数
    if (params) {
        [allParams setDictionary:params];
    }
    
//     拼接token参数
    NSString *token = [AccountTool sharedAccountTool].account.accessToken;
    if (token) {
        [allParams setObject:token forKey:@"access_token"];
    }
    
    NSURLRequest *post = [client requestWithMethod:method path:path parameters:allParams];
    
    // 2.创建AFJSONRequestOperation对象
    NSOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:post
              success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                  if (success == nil) return;
                  success(JSON);
              }
             failure : ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                 if (failure == nil) return;
                 failure(error);
             }];
    
    // 3.发送请求
    [op start];
    
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path params:params success:success failure:failure method:@"GET"];
    
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path params:params success:success failure:failure method:@"POST"];
}

+ (void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView {
     [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}
@end
