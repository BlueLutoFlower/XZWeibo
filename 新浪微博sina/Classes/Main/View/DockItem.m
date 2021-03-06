//
//  DockItem.m
//  sina
//
//  Created by zheng on 15/12/26.
//  Copyright (c) 2015年 zheng. All rights reserved.
//

#import "DockItem.h"

// 被选中的图片背景
#define kDockItemSelectedBG @"tabbar_slider.png"
// 文字的高度比例
#define kTitleRatio 0.4

@implementation DockItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 3.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
        // 4.设置选中时的背景
        [self setBackgroundImage:[UIImage imageNamed:kDockItemSelectedBG] forState:UIControlStateSelected];
    }
    return self;
}

#pragma mark 覆盖父类在highlighted时的所有操作
- (void)setHighlighted:(BOOL)highlighted {
//        [super setHighlighted:highlighted];
}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * (1 - kTitleRatio);
    return CGRectMake(imageX, imageY, imageW, imageH);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0;
    CGFloat titleH = contentRect.size.height * kTitleRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height - titleH;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
