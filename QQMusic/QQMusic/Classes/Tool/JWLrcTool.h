//
//  JWLrcTool.h
//  QQMusic
//
//  Created by 黄进文 on 15/10/22.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWLrcTool : NSObject

/** 解析歌词 */
+ (NSArray *)lrcToolWithLrcName:(NSString *)lrcName;

@end
