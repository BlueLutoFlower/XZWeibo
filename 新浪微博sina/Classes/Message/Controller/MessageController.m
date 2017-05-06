//
//  MessageController.m
//  sina
//
//  Created by zheng on 15/12/26.
//  Copyright (c) 2015年 zheng. All rights reserved.
//

#import "MessageController.h"

@interface MessageController ()

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息";
    
    // .设置右上角按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发私信" style:UIBarButtonItemStyleBordered target:nil action:nil];
}


@end
