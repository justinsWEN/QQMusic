//
//  JWLrcLine.h
//  QQMusic
//
//  Created by 黄进文 on 15/10/22.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWLrcLine : NSObject

/** 歌词 */
@property (nonatomic, copy) NSString *text;

/** 时间 */
@property (nonatomic, assign) NSTimeInterval time;

- (instancetype)initWithLrcString:(NSString *)lrcString;

+ (instancetype)lrcLineWithLrcString:(NSString *)lrcString;

@end
