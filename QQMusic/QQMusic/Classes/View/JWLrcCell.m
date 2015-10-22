//
//  JWLrcCell.m
//  QQMusic
//
//  Created by 黄进文 on 15/10/22.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import "JWLrcCell.h"
#import "JWLrcLabel.h"
#import "Masonry.h"

@implementation JWLrcCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 1. 创建自定义Label
        JWLrcLabel *lrcLabel = [[JWLrcLabel alloc] init];
        // 2. 将自定义label添加到cell中
        [self.contentView addSubview:lrcLabel];
        // 3.给自定义label添加约束
        [lrcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
        // 4. 设置自定义Label的属性
        lrcLabel.textColor = [UIColor whiteColor];
        lrcLabel.font = [UIFont systemFontOfSize:15.0];
        
        // 5. 设置cell的属性
        self.backgroundColor = [UIColor clearColor];
        // 去掉点击cell有背景颜色显示
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.lrcLabel = lrcLabel;
    }
    return self;
}

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView {
    
    static NSString *const cellID = @"cell";
    JWLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[JWLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
