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
@end
