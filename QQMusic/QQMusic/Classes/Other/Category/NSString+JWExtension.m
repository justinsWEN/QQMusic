//
//  NSString+JWExtension.m
//  QQMusic
//
//  Created by 黄进文 on 15/10/21.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import "NSString+JWExtension.h"

@implementation NSString (JWExtension)

+ (NSString *)stringWithTime:(NSTimeInterval)time {
    
    NSInteger minute = time / 60;
    NSInteger second = (NSInteger)time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", minute, second];
}
@end
