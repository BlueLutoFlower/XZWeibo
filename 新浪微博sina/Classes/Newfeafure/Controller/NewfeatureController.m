//
//  NewfeatureController.m
//  新浪微博sina
//
//  Created by zheng on 16/1/27.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "NewfeatureController.h"
#import "OauthController.h"

#define kCount 4

@interface NewfeatureController () <UIScrollViewAccessibilityDelegate>
{
    UIScrollView *_scroll;
    UIPageControl *_page;
}
@end

@implementation NewfeatureController

- (void)loadView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = [[UIScreen mainScreen] applicationFrame];
    imageView.image = [UIImage imageNamed:@"new_feature_background"];
    
    imageView	.userInteractionEnabled = YES;
    self.view = imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollView];
    
    [self addScrollImages];
    [self addPageControl];
    
}

#pragma mark - 监听按钮点击
#pragma mark 开始
- (void)start {
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.view.window.rootViewController = [[OauthController alloc] init];
}

#pragma mark 分享
- (void)share:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

#pragma mark - UI界面初始化
#pragma mark 添加滚动视图
- (void)addScrollView {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    CGSize size = scroll.frame.size;
    scroll.contentSize = CGSizeMake(size.width * kCount, 0);
    scroll.showsHorizontalScrollIndicator = NO;
    //设置分页
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    [self.view addSubview:scroll];
    _scroll = scroll;
}

#pragma mark 添加滚动显示的图片
- (void)addScrollImages {
    CGSize size = _scroll.frame.size;
    for (int i = 0; i < kCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *image = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:image];
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        [_scroll addSubview:imageView];
        
        if (i == kCount - 1) {
            imageView.userInteractionEnabled = YES;
            //立即体验按钮
            UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *startNormal = [UIImage imageNamed:@"new_feature_finish_button"];
            UIImage *startHighted = [UIImage imageNamed:@"new_feature_finish_button_highlighted"];
            [start setBackgroundImage:startNormal forState:UIControlStateNormal];
            [start setBackgroundImage:startHighted forState:UIControlStateHighlighted];
            start.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.8);
            start.bounds = (CGRect){CGPointZero,startNormal.size};
            [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:start];
            
            //分享
            UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
            share.selected = YES;
            UIImage *shareFalse = [UIImage imageNamed:@"new_feature_share_false"];
            UIImage *shareTrue = [UIImage imageNamed:@"new_feature_share_true"];
            [share setBackgroundImage:shareTrue forState:UIControlStateNormal];
            [share setBackgroundImage:shareFalse forState:UIControlStateSelected];
            share.center = CGPointMake(start.center.x,start.center.y - 50);
            share.bounds = (CGRect){CGPointZero,shareTrue.size};
            [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:share];
        }
    }
    
}

#pragma mark 添加分页指示器
- (void)addPageControl {
    CGSize size = _scroll.frame.size;
    UIPageControl *page = [[UIPageControl alloc] init];
    page.center = CGPointMake(size.width * 0.5, size.height * 0.95);
    page.numberOfPages = kCount;
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
    //    page.bounds = CGRectMake(0, 0, 150, 0);
    [self.view addSubview:page];
    _page = page;
}

#pragma mark - 滚动代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

@end
