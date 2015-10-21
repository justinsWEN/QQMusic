//
//  JWMusicTool.m
//  QQMusic
//
//  Created by 黄进文 on 15/10/21.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import "JWMusicTool.h"
#import "JWMusic.h"
#import "MJExtension.h"

@implementation JWMusicTool

static NSArray *musics_;
static JWMusic *playingMusic_;

// 类第一次使用时调用这个方法
+ (void)initialize {
    
    musics_ = [JWMusic objectArrayWithFilename:@"Musics.plist"];
    playingMusic_ = musics_[7];
}

+ (NSArray *)musics {
    
    return musics_;
}

+ (JWMusic *)playingMusic {
    
    return playingMusic_;
}

+ (void)setPlayingMusic:(JWMusic *)playingMusic {
    
    playingMusic_ = playingMusic;
}

+ (JWMusic *)previousMusic {
    
    // 1. 获取当前歌曲的下标值
    NSInteger currentIndex = [musics_ indexOfObject:playingMusic_];
    
    // 2. 获取上一首的下标值
    NSInteger previousIndex = currentIndex - 1;
    
    if (previousIndex < 0) {
     
        // 设置为最后一首
        previousIndex = musics_.count - 1;
    }
    
    // 3. 返回上一首歌曲
    return [musics_ objectAtIndex:previousIndex];
}

+ (JWMusic *)nextMusic {
    
    // 1. 获取当前歌曲的下标值
    NSInteger currentIndex = [musics_ indexOfObject:playingMusic_];
    
    // 2. 获取下一首的下标值
    NSInteger nextIndex = currentIndex + 1;
    
    if (nextIndex > musics_.count - 1) {
        
        // 设置为最后一首
        nextIndex = 0;
    }
    
    // 3. 返回上一首歌曲
    return [musics_ objectAtIndex:nextIndex];
}

@end














