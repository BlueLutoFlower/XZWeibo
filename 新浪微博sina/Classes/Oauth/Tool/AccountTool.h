//
//  AccountTool.h
//  新浪微博sina
//
//  Created by zheng on 16/1/29.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "Singleton.h"

@interface AccountTool : NSObject

single_interface(AccountTool)

// 获得当前账号
@property (nonatomic, readonly) Account *account;

- (void)saveAccount:(Account *)account;

@end
