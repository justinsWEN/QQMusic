//
//  JWLrcCell.m
//  QQMusic
//
//  Created by 黄进文 on 15/10/22.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import "JWLrcCell.h"

@implementation JWLrcCell

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView {
    
    static NSString *const cellID = @"cell";
    JWLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[JWLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        // 设置cell的背景颜色
        cell.backgroundColor = [UIColor clearColor];
        // 去掉点击cell有背景颜色显示
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 设置textLabel的属性
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}

@end
