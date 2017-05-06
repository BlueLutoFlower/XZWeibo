//
//  MainController.m
//  新浪微博sina
//
//  Created by zheng on 16/1/27.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "MainController.h"
#import "HomeController.h"
#import "MeController.h"
#import "SquareController.h"
#import "MoreController.h"
#import "MessageController.h"
#import "WBNavigationController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化所有的子控制器
    [self addAllChildControllers];
    
    // 2.初始化DockItems
    [self addDockItems];
}

- (void)addAllChildControllers {
    // 1.首页
    HomeController *home = [[HomeController alloc] init];
    WBNavigationController *navHome = [[WBNavigationController alloc] initWithRootViewController:home];
    [self addChildViewController:navHome];
    
    // 2.消息
    MessageController *message = [[MessageController alloc] init];
    WBNavigationController *navMessage = [[WBNavigationController alloc] initWithRootViewController:message];
    [self addChildViewController:navMessage];
    
    // 3.我
    MeController *me = [[MeController alloc] init];
    WBNavigationController *navMe = [[WBNavigationController alloc] initWithRootViewController:me];
    [self addChildViewController:navMe];
    
    // 4.广场
    SquareController *square = [[SquareController alloc] init];
    WBNavigationController *navSquare = [[WBNavigationController alloc] initWithRootViewController:square];
    [self addChildViewController:navSquare];
    
    // 5.更多
    MoreController *more = [[MoreController alloc] initWithStyle:UITableViewStyleGrouped];
    WBNavigationController *navMore = [[WBNavigationController alloc] initWithRootViewController:more];
    [self addChildViewController:navMore];
}

- (void)addDockItems {
    // 1.设置Dock的背景图片
    _dock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    
    // 2.往Dock里面填充内容
    [_dock addItemWithIcon:@"tabbar_home.png" selectedIcon:@"tabbar_home_selected.png" title:@"首页"];
    [_dock addItemWithIcon:@"tabbar_message_center.png" selectedIcon:@"tabbar_message_center_selected.png" title:@"消息"];
    [_dock addItemWithIcon:@"tabbar_profile.png" selectedIcon:@"tabbar_profile_selected.png" title:@"我"];
    [_dock addItemWithIcon:@"tabbar_discover.png" selectedIcon:@"tabbar_discover_selected.png" title:@"广场"];
    [_dock addItemWithIcon:@"tabbar_more.png" selectedIcon:@"tabbar_more_selected.png"  title:@"更多"];
}

@end
