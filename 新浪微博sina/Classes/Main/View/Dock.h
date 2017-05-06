//
//  Dock.h
//  sina
//
//  Created by zheng on 15/12/26.
//  Copyright (c) 2015年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dock;
@protocol DockDelegate <NSObject>

- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to;

@end

@interface Dock : UIView

// 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title;

#pragma mark - DockDelegate
@property (nonatomic, weak) id <DockDelegate> delegate;

@end
