//
//  HomeController.m
//  新浪微博sina
//
//  Created by zheng on 16/1/31.
//  Copyright (c) 2016年 zheng. All rights reserved.
//

#import "HomeController.h"
#import "UIBarButtonItem+MJ.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Status.h"
#import "User.h"
#import "StatusTool.h"
#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "MJRefresh.h"
#import "UIImage+MJ.h"

@interface HomeController () <MJRefreshBaseViewDelegate>
{
    NSMutableArray *_statusFrame;
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置界面属性
    [self buildUI];
    
//    // 获取微博数据
//    [self loadStatusData];
    
    // 2.集成刷新控件
    [self addRefreshViews];
}

#pragma mark 集成刷新控件
- (void)addRefreshViews
{
    _statusFrame = [NSMutableArray array];
    
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    [header beginRefreshing];
    
    // 2.上拉加载更多
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
}

#pragma mark 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        // 上拉加载更多
        [self loadMoreData:refreshView];
    } else {
        // 下拉刷新
        [self loadNewData:refreshView];
    }
}

#pragma mark 加载最新数据
- (void)loadNewData:(MJRefreshBaseView *)refreshView {
    // 1.第1条微博的ID
    StatusCellFrame *f = _statusFrame.count?_statusFrame[0]:nil;
    long long first = [f.status ID];
    
    // 2.获取微博数据
    [StatusTool statusesWithSinceId:first maxId:0 success:^(NSArray *statues){
        // 1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statues) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [newFrames addObject:f];
        }
        
        // 2.将newFrames整体插入到旧数据的前面
        [_statusFrame insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        // 3.刷新表格
        [self.tableView reloadData];
        
        // 4.让刷新控件停止刷新状态
        [refreshView endRefreshing];
        
        // 5.顶部展示最新微博的数目
        [self showNewStatusCount:statues.count];
    } failure:^(NSError *error) {
        [refreshView endRefreshing];
    }];
}

#pragma mark 加载更多数据
- (void)loadMoreData:(MJRefreshBaseView *)refreshView {
    // 1.最后1条微博的ID
    StatusCellFrame *f = [_statusFrame lastObject];
    long long last = [f.status ID];
    
    // 2.获取微博数据
    [StatusTool statusesWithSinceId:0 maxId:last - 1 success:^(NSArray *statues){
        // 1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statues) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [newFrames addObject:f];
        }
        
        // 2.将newFrames整体插入到旧数据的后面
        [_statusFrame addObjectsFromArray:newFrames];
        
        // 3.刷新表格
        [self.tableView reloadData];
        
        // 4.让刷新控件停止刷新状态
        [refreshView endRefreshing];
    } failure:^(NSError *error) {
        [refreshView endRefreshing];
    }];
}

#pragma mark 展示最新微博的数目
- (void)showNewStatusCount:(int)count
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enabled = NO;
    btn.adjustsImageWhenDisabled = NO;
    
    [btn setBackgroundImage:[UIImage resizedImage:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
    CGFloat w = self.view.frame.size.width;
    CGFloat h = 35;
    btn.frame = CGRectMake(0, 44 - h, w, h);
    NSString *title = count?[NSString stringWithFormat:@"共有%d条新的微博", count]:@"没有新的微博";
    [btn setTitle:title forState:UIControlStateNormal];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.开始执行动画
    CGFloat duration = 0.5;
    
    [UIView animateWithDuration:duration animations:^{ // 下来
        btn.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{// 上去
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

//- (void)loadStatusData {
//    _statusFrame = [NSMutableArray array];
//    [StatusTool statusesWithSinceId:0 maxId:0 success:^(NSArray *status) {
//        for (Status *s in status) {
//            StatusCellFrame *f = [[StatusCellFrame alloc] init];
//            f.status = s;
//            [_statusFrame addObject:f];
//        }
//        [self.tableView reloadData];
//    } failure:nil];
//    
//}

#pragma mark 设置界面属性
- (void)buildUI {
    // 设置标题
    self.title = @"首页";
    
    // 左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_compose.png" highlightedIcon:@"navigationbar_compose_highlighted.png" target:self action:@selector(sendStatus)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop.png" highlightedIcon:@"navigationbar_pop_highlighted.png" target:self action:@selector(popMenu)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)sendStatus {
    NSLog(@"发微博");
}

- (void)popMenu {
    NSLog(@"弹出菜单");
}

#pragma mark UITableViewCell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _statusFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.statusCellFrame = _statusFrame[indexPath.row];
    
    
    return cell;
}

#pragma mark 返回每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [_statusFrame[indexPath.row] cellHeight];
}

@end
