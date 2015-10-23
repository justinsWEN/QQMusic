//
//  JWLrcCell.h
//  QQMusic
//
//  Created by 黄进文 on 15/10/22.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JWLrcLabel;
@interface JWLrcCell : UITableViewCell

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;
/** 显示歌词的label */
@property (nonatomic, weak) JWLrcLabel *lrcLabel;

@end
