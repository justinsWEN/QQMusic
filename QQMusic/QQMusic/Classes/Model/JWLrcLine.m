//
//  JWLrcLine.m
//  QQMusic
//
//  Created by 黄进文 on 15/10/22.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import "JWLrcLine.h"

@implementation JWLrcLine

- (instancetype)initWithLrcString:(NSString *)lrcString {
    
    if (self = [super init]) {
     
        // 截取时间跟歌词分开
        NSArray *lrcArray = [lrcString componentsSeparatedByString:@"]"];
        self.text = lrcArray[1]; // 歌词
        // [2:20.80 -> 2:20.80
        self.time = [self timeWithString:[lrcArray[0] substringFromIndex:1]]; // 时间
    }
    return self;
}

+ (instancetype)lrcLineWithLrcString:(NSString *)lrcString {
    
    return [[self alloc] initWithLrcString:lrcString]; // 这个self为调用该类方法的那个类
}

- (NSTimeInterval)timeWithString:(NSString *)timeString {
    
    // 分、秒、毫秒数组
    NSArray *timeArray = [timeString componentsSeparatedByString:@":"];
    
    NSInteger min = [timeArray[0] integerValue];
    NSInteger sec = [[timeArray[1] componentsSeparatedByString:@"."][0] integerValue];
    NSInteger haomiao = [[timeArray[1] componentsSeparatedByString:@"."][1] integerValue];
    
    return min * 60 + sec + haomiao * 0.01;
}

@end
