//
//  Dock.m
//  sina
//
//  Created by zheng on 15/12/26.
//  Copyright (c) 2015年 zheng. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"

@interface Dock()
{
    DockItem *_selectedItem;
}
@end

@implementation Dock

- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title {
    DockItem *item = [[DockItem alloc] init];
    //文字
    [item setTitle:title forState:UIControlStateNormal];
    //图标
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    //监听item的点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    //添加item
    [self addSubview:item];
    
    //计算添加进来的按钮位置
    NSUInteger count = self.subviews.count;
    if (count == 1) {
        [self itemClick:item];
    }
    
    CGFloat height = self.frame.size.height;
    CGFloat weight = self.frame.size.width / count;
    for (int i = 0 ; i < count; i++) {
        DockItem *dockItem = self.subviews[i];
        dockItem.tag = i;
        dockItem.frame = CGRectMake(weight * i, 0, weight, height);
    }
}

#pragma mark 监听item点击
- (void)itemClick:(DockItem *)item {
    // 0.通知代理
    if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
        [_delegate dock:self itemSelectedFrom:_selectedItem.tag to:item.tag];
    }
    
    // 1.取消选中当前选中的item
    _selectedItem.selected = NO;
    
    // 2.选中点击的item
    item.selected = YES;
    
    // 3.赋值
    _selectedItem = item;
}

@end
