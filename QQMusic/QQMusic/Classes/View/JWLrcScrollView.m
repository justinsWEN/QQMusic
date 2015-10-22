//
//  JWLrcScrollView.m
//  QQMusic
//
//  Created by 黄进文 on 15/10/21.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import "JWLrcScrollView.h"
#import "Masonry.h"
#import "JWLrcCell.h"
#import "JWLrcTool.h"
#import "JWLrcLine.h"
#import "JWLrcLabel.h"

@interface JWLrcScrollView()<UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *lrcLines;
/** 记录当前歌词的位置 */
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation JWLrcScrollView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView {
    
    // 创建TableView
    UITableView *tableView = [[UITableView alloc] init];
    
    // 将tableView添加到ScrollView
    [self addSubview:tableView];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 30;
}

- (void)layoutSubviews {
    
    // 给tableView添加约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(self.bounds.size.width);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    // 清除tableView的背景颜色
    self.tableView.backgroundColor = [UIColor clearColor];
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置tableView的上下内边距
    self.tableView.contentInset = UIEdgeInsetsMake(self.bounds.size.height * 0.5, 0, self.bounds.size.height * 0.5, 0);
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.lrcLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 创建cell
    JWLrcCell *cell = [JWLrcCell lrcCellWithTableView:tableView];
    
    if (self.currentIndex == indexPath.row) {
        
        cell.lrcLabel.font = [UIFont systemFontOfSize:18.0];
        cell.lrcLabel.textColor = [UIColor orangeColor];
    }
    else {
        
        cell.lrcLabel.font = [UIFont systemFontOfSize:14.0];
        cell.lrcLabel.textColor = [UIColor whiteColor];
    }
    // 获取模型数据
    JWLrcLine *lrcLine = self.lrcLines[indexPath.row];
    
    cell.lrcLabel.text = lrcLine.text;
    
    return cell;
}

#pragma mark - 重写setLrcName方法
- (void)setLrcName:(NSString *)lrcName {
    
    _lrcName = lrcName;
    
    // 解析歌词
    self.lrcLines = [JWLrcTool lrcToolWithLrcName:lrcName];
    
    // 刷新列表
    [self.tableView reloadData];
}

#pragma mark - 重写setCurrentTime方法
- (void)setCurrentTime:(NSTimeInterval)currentTime {
    
    _currentTime = currentTime;
    
    // 找出需要显示的歌词
    NSInteger count = self.lrcLines.count;
    for (int i = 0; i < count; ++i) {
        
        // 1. 拿到i位置的歌词
        JWLrcLine *currentLrcLine = self.lrcLines[i];
        // 2. 拿到i+1位置的歌词
        NSInteger nextIndex = i + 1;
        if (nextIndex >= count) return;
        JWLrcLine *nextLrcLine = self.lrcLines[nextIndex];
        // 3. 当前时间大于i位置歌词的时间并且小于i+1位置的歌词时间
        if (currentTime >= currentLrcLine.time && currentTime < nextLrcLine.time && self.currentIndex != i) {
            
            // 计算i位置的indexPath
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSIndexPath *previousPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            // 记录当前歌词的位置
            self.currentIndex = i;
            
            // 刷新i位置的cell
            [self.tableView reloadRowsAtIndexPaths:@[indexPath, previousPath] withRowAnimation:UITableViewRowAnimationNone];
            
            // 让tableView的i位置cell滚动到中间
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }
}

@end




















