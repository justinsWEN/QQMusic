//
//  JWMusicTool.h
//  QQMusic
//
//  Created by 黄进文 on 15/10/21.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JWMusic;
@interface JWMusicTool : NSObject

/**
 *  返回所有的歌曲
 *
 *  @return 所有的歌曲
 */
+ (NSArray *)musics;

/**
 *  获取当前正在播放的歌曲
 *
 *  @return 正在播放的歌曲
 */
+ (JWMusic *)playingMusic;

/**
 *  设置正在播放的歌曲
 *
 *  @param playingMusic 正在播放的歌曲
 */
+ (void)setPlayingMusic:(JWMusic *)playingMusic;

/**
 *  返回上一首歌曲
 *
 *  @param 上一首歌曲
 */
+ (JWMusic *)previousMusic;

/**
 *  返回下一首歌曲
 *
 *  @param 下一首歌曲
 */
+ (JWMusic *)nextMusic;

@end
