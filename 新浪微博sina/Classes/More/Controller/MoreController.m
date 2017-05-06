//
//  MoreController.m
//  sina
//
//  Created by zheng on 15/12/26.
//  Copyright (c) 2015年 zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark 这个类只用在MoreController
@interface LogutBtn : UIButton
@end

@implementation LogutBtn
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2 * x;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
}
@end

#import "MoreController.h"
#import "UIImage+MJ.h"
#import "GroupCell.h"

@interface MoreController ()
{
    NSArray *_data;
}
@end

@implementation MoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.搭建UI界面
    [self buildUI];
    
    // 2.读取plist文件的内容
    [self loadPlist];
    
    // 3.设置tableView属性
    [self buildTableView];
    
}

#pragma mark 读取plist文件的内容
- (void)loadPlist {
    // 1.获得路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"More" withExtension:@"plist"];
    
    // 2.读取数据
    _data = [NSArray arrayWithContentsOfURL:url];
}

#pragma mark 搭建UI界面
- (void)buildUI
{
    // 1.设置标题
    self.title = @"更多";
    // 2.设置右上角按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:nil action:nil];    
}

#pragma mark 设置tableView属性
- (void)buildTableView {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    
    // 3.要在tableView底部添加一个按钮
    LogutBtn *logout = [LogutBtn buttonWithType:UIButtonTypeCustom];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_button_big_red.png"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_button_big_red_highlighted.png"] forState:UIControlStateHighlighted];
    logout.bounds = CGRectMake(0, 0, 0, 44);
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    self.tableView.tableFooterView = logout;
    
    // 增加底部额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 10, 0);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_data[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ID";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[GroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        // 设置cell所在的tableView
        cell.myTableView = tableView;
    }
    
    // 1.取出这行对应的字典数据
    NSDictionary *dict = _data[indexPath.section][indexPath.row];
    
    //把cell的背景图片设为nil
    cell.backgroundColor = nil;
    //在xcode6.0以前textLabel是有背景图片的
    //cell.textLabel.backgroundColor = [UIColor clearColor];

    // 2.设置文字
    cell.textLabel.text = dict[@"name"];
    
    // 3.设置cell的背景
    cell.indexPath = indexPath;
    
    // 4.设置cell的类型（设置右边显示什么东西）
    if (indexPath.section == 2) {
        cell.cellType = kCellTypeLabel;
        cell.rightLabel.text = indexPath.row?@"有图模式":@"经典主题";
    } else {
//        cell.cellType = kCellTypeArrow;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
