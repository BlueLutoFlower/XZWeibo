//
//  StatusCell.m
//  新浪微博sina
//
//  Created by zheng on 16/2/1.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "StatusCell.h"
#import "Common.h"
#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "IconView.h"
#import "UIImage+MJ.h"
#import "ImageListView.h"
#import "StatusDock.h"

@interface StatusCell()
{
    IconView *_icon; // 头像
    UILabel *_screenName; // 昵称
    UIImageView *_mbIcon; // 会员图标
    UILabel *_time; // 时间
    UILabel *_source; // 来源
    UILabel *_text; // 内容
    ImageListView *_image; // 配图
    StatusDock *_dock; // 底部的操作条
    
    UIImageView *_retweeted; // 被转发微博的父控件
    UILabel *_retweetedScreenName; // 被转发微博作者的昵称
    UILabel *_retweetedText; // 被转发微博的内容
    ImageListView *_retweetedImage; // 被转发微博的配图
}

@end

@implementation StatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加微博本身的子控件
        [self addAllSubviews];
        
        // 2.添加被转发微博的子控件
        [self addReweetedAllSubviews];
        
        // 3.设置背景
        [self setBg];
    }
    return self;
    
}

#pragma mark 设置背景
- (void)setBg
{
    // 1.默认背景
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage resizedImage:@"common_card_background.png"]];
    
    // 2.长按背景
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage resizedImage:@"common_card_background_highlighted.png"]];
}

- (void)addAllSubviews {
    // 1.头像
    _icon = [[IconView alloc] init];
    [self.contentView addSubview:_icon];
    
    // 2.昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    // 皇冠图标
    _mbIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    [self.contentView addSubview:_mbIcon];
    
    // 3.时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    _time.textColor = kColor(246, 165, 68);
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    // 4.来源
    _source = [[UILabel alloc] init];
    _source.font = kSourceFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    // 5.内容
    _text = [[UILabel alloc] init];
    _text.numberOfLines = 0;
    _text.font = kTextFont;
    _text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_text];
    
    // 6.配图
    _image = [[ImageListView alloc] init];
    [self.contentView addSubview:_image];
    
    // 7.操作条
    CGFloat y = self.frame.size.height - kStatusDockHeight;
    _dock = [[StatusDock alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
    [self.contentView addSubview:_dock];
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = kTableBorderWidth;
    frame.origin.y += kTableBorderWidth;
    frame.size.width -= kTableBorderWidth * 2;
    frame.size.height -= kCellMargin;
    
    [super setFrame:frame];
}

#pragma mark 被转发微博的子控件
- (void)addReweetedAllSubviews {
    // 1.被转发微博的父控件
    _retweeted = [[UIImageView alloc] init];
    _retweeted.image = [UIImage resizedImage:@"timeline_retweet_background.png" xPos:0.9 yPos:0.5];
    [self.contentView addSubview:_retweeted];
    
    // 2.被转发微博的昵称
    _retweetedScreenName = [[UILabel alloc] init];
    _retweetedScreenName.font = kRetweetedScreenNameFont;
    _retweetedScreenName.textColor = kRetweetedScreenNameColor;
    _retweetedScreenName.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedScreenName];
    
    // 3.被转发微博的内容
    _retweetedText = [[UILabel alloc] init];
    _retweetedText.numberOfLines = 0;
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedText];
    
    // 4.被转发微博的配图
    _retweetedImage = [[ImageListView alloc] init];
    [_retweeted addSubview:_retweetedImage];
}

- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame {
    _statusCellFrame = statusCellFrame;
    
    Status *s = statusCellFrame.status;
    
    // 1.头像
    _icon.frame = statusCellFrame.iconFrame;
    [_icon setUser:s.user type:kIconTypeSmall];
    
    // 2.昵称
    _screenName.frame = statusCellFrame.screenNameFrame;
    _screenName.text = s.user.screenName;
    
    // 判断是不是会员
    if (s.user.mbtype == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    } else {
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = statusCellFrame.mbIconFrame;
    }
    
    // 3.时间
    _time.frame = statusCellFrame.timeFrame;
    _time.text = s.createdAt;
    
    // 4.来源
    _source.frame = statusCellFrame.sourceFrame;
    _source.text = s.source;
    
    // 5.内容
    _text.frame = statusCellFrame.textFrame;
    _text.text = s.text;
    
    // 6.配图
    if (s.picUrls.count) {
        _image.hidden = NO;
        _image.frame = statusCellFrame.imageFrame;
        _image.imageUrls = s.picUrls;
        
        
        
    } else {
        _image.hidden = YES;
    }
    
    // 7.被转发微博
    if (s.retweetedStatus) {
        _retweeted.hidden = NO;
        
        _retweeted.frame = statusCellFrame.retweetedFrame;
        
        // 8.昵称
        _retweetedScreenName.frame = statusCellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text = [NSString stringWithFormat:@"@%@", s.retweetedStatus.user.screenName];
        
        // 9.内容
        _retweetedText.frame = statusCellFrame.retweetedTextFrame;
        _retweetedText.text = s.retweetedStatus.text;
        
        // 10.配图
        if (s.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden = NO;
            
            _retweetedImage.frame = statusCellFrame.retweetedImageFrame;
            _retweetedImage.imageUrls = s.retweetedStatus.picUrls;
            
            
            
        } else {
            _retweetedImage.hidden = YES;
        }
    } else {
        _retweeted.hidden = YES;
    }
}

@end
