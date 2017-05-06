//
//  AppDelegate.m
//  新浪微博sina
//
//  Created by zheng on 16/1/27.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "NewfeatureController.h"
#import "MainController.h"
#import "OauthController.h"
#import "AccountTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //键
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    //version
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    //系统原本的version
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //判断version
    if ([version isEqualToString:saveVersion]) {// 不是第一次使用这个版本r
        if ([AccountTool sharedAccountTool].account) {
            // 显示状态栏
            application.statusBarHidden = NO;
            self.window.rootViewController = [[MainController alloc] init];
        } else {
            // 不显示状态栏
            application.statusBarHidden = YES;
            self.window.rootViewController = [[OauthController alloc] init];
        }
    } else { //是第一次使用这个版本
    
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.window.rootViewController = [[NewfeatureController alloc] init];
    }
//    self.window.rootViewController = [[MainController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
