//
//  JWLrcTool.m
//  QQMusic
//
//  Created by 黄进文 on 15/10/22.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import "JWLrcTool.h"
#import "JWLrcLine.h"

@implementation JWLrcTool

+ (NSArray *)lrcToolWithLrcName:(NSString *)lrcName {
    
    // 1. 获取歌词的路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
    // 2. 读取该文件的歌词
    NSString *lrcSong = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    // 3. 获取歌词的数组
    NSArray *lrcArray = [lrcSong componentsSeparatedByString:@"\n"]; // 按换行截取歌词
    // 4. 将歌词转换为模型对象放到数组中
    NSMutableArray *lrcLineArray = [NSMutableArray array];
    for (NSString *lrcString in lrcArray) {
        // 4.1 过滤掉不需要的行
        if ([lrcString hasPrefix:@"[ti:"] || [lrcString hasPrefix:@"[ar:"] || [lrcString hasPrefix:@"[al:"] || ![lrcString hasPrefix:@"["]) continue;
        // 解析每一句歌词为模型对象
        JWLrcLine *lrcLine = [JWLrcLine lrcLineWithLrcString:lrcString];
        [lrcLineArray addObject:lrcLine];
    }
    return lrcLineArray;
}

@end
