//
//  JWLrcLabel.m
//  QQMusic
//
//  Created by 黄进文 on 15/10/22.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import "JWLrcLabel.h"

@implementation JWLrcLabel

/** 重写setProgress */
- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    
    // 每次调用setProgress都重新调用drawRect:方法一次
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    // 设置画颜色范围
    CGRect drawRect = CGRectMake(0, 0, rect.size.width * self.progress, rect.size.height);
    // 设置颜色
    [[UIColor greenColor] set];
    // 设置字体颜色
    // R = S*Da S透明度为1，Da为字体的透明(kCGBlendModeSourceIn)
    UIRectFillUsingBlendMode(drawRect, kCGBlendModeSourceIn);
}

@end
