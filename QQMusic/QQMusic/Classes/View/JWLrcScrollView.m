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

@interface JWLrcScrollView()<UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *lrcLines;
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
    
    // 获取模型数据
    JWLrcLine *lrcLine = self.lrcLines[indexPath.row];
    
    cell.textLabel.text = lrcLine.text;
    
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

@end




















