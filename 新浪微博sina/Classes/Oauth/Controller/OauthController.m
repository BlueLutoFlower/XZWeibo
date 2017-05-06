//
//  OauthController.m
//  新浪微博sina
//
//  Created by zheng on 16/1/29.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "OauthController.h"
#import "Weibocfg.h"
#import "HttpTool.h"
#import "MainController.h"
#import "AccountTool.h"
#import "MBProgressHUD.h"

@interface OauthController () <UIWebViewDelegate>
{
    UIWebView *_web;
}

@end

@implementation OauthController

- (void)loadView {
    _web = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view = _web;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlStr = [kAuthorizeURL stringByAppendingFormat:@"?client_id=%@&redirect_uri=%@&display=mobile", kAppKey, kRedirectURI];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_web loadRequest:request];
    _web.delegate = self;
}

#pragma mark 拦截webView的所有请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // 1.获得全路径
    NSString *urlStr = request.URL.absoluteString;
    NSLog(@"%@",urlStr);
    // 2.查找code=的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length != 0) {// 跳到“回调地址”，说明已经授权成功
        
        int index = (int)(range.location + range.length);
        NSString *requestToKen = [urlStr substringFromIndex:index];
        
        //3.POST请求，取accessToken
        [self getAccessToken:requestToKen];
        return NO;
    }
    
    return YES;
}

- (void)getAccessToken:(NSString *)requestToken {
    
    [HttpTool postWithPath:@"oauth2/access_token"
                    params:@{
                             @"client_id" : kAppKey,
                             @"client_secret" : kAppSecret,
                             @"grant_type" : @"authorization_code",
                             @"redirect_uri" : kRedirectURI,
                             @"code" : requestToken
                             }
                   success:^(id JSON) {
                       
                       Account *account = [[Account alloc] init];
                       account.accessToken = JSON[@"access_token"];
                       account.uid = JSON[@"uid"];
                       [[AccountTool sharedAccountTool] saveAccount:account];
                       
                       self.view.window.rootViewController = [[MainController alloc] init];
                       
//                       NSLog(@"请求成功——————%@",JSON);
                   }
                   failure:^(NSError *error) {
//                       NSLog(@"请求失败——————%@",error);
                   }];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.dimBackground = YES;
    hud.labelText = @"正在加载中";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end
