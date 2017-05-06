//
//  ImageItemView.m
//  新浪微博sina
//
//  Created by zheng on 16/2/3.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "ImageItemView.h"
#import "HttpTool.h"

@interface ImageItemView()
{
    UIImageView *_gifView;
}
@end

@implementation ImageItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif.png"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    
    // 1.加载图片
    [HttpTool downloadImage:url place:[UIImage imageNamed:@"timeline_image_loading.png"] imageView:self];
    //    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageLowPriority| SDWebImageRetryFailed];
    
    // 2.是否为gif
    _gifView.hidden = ![url.lowercaseString hasSuffix:@"gif"];
    //    if ([url.lowercaseString hasSuffix:@"gif"]) {
    //        _gifView.hidden = NO;
    //    } else {
    //        _gifView.hidden = YES;
    //    }
}

- (void)setFrame:(CGRect)frame
{
    // 1.设置gifView的位置
    CGRect gifFrame = _gifView.frame;
    gifFrame.origin.x = frame.size.width - gifFrame.size.width;
    gifFrame.origin.y =  frame.size.height - gifFrame.size.height;
    _gifView.frame = gifFrame;
    
    [super setFrame:frame];
}

@end
