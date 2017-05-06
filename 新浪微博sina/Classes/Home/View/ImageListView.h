//
//  ImageListView.h
//  新浪微博sina
//
//  Created by zheng on 16/2/2.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListView : UIView

// 所有图片的url
@property (nonatomic, strong) NSArray *imageUrls;

+ (CGSize)imageListSizeWithCount:(int)count;

@end
