//
//  JWAudioTool.m
//  02-播放音效
//
//  Created by 黄进文 on 15/10/20.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import "JWAudioTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation JWAudioTool

static NSMutableDictionary *soundIDs_;

static NSMutableDictionary *players_;

// 类第一次使用时调用
+ (void)initialize {
    
    soundIDs_ = [NSMutableDictionary dictionary];
    players_ = [NSMutableDictionary dictionary];
}

+ (void)playSoundWithSoundName:(NSString *)soundName {
    
    // 从字典中取出之前保存的soundID
    SystemSoundID soundID = [[soundIDs_ objectForKey:soundName] unsignedIntValue];
    
    // 2、判断如果取出的为0
    if (soundID == 0) {
        
        // 根据音频文件资源创建SystemSoundID(赋值)
        NSURL *url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        CFURLRef urlRef = (__bridge CFURLRef)(url); // 桥接
        AudioServicesCreateSystemSoundID(urlRef, &soundID); // 创建
        // soundID为0存入字典
        [soundIDs_ setObject:@(soundID) forKey:soundName];
    }
    AudioServicesPlaySystemSound(soundID);
}

+ (AVAudioPlayer *)playMusicWithMusicName:(NSString *)musicName {
    
    // 从字典中取出之前保存的名
    AVAudioPlayer *player = players_[musicName];
    // 判断播放器是否为空，为空则创建播放器
    if (player == nil) {
        
        // 获取资源的url
        NSURL *url = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
        // 创建播放器
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        // 如果play之前没有创建过，那保存到字典
        [players_ setObject:player forKey:musicName];
    }
    // 播放音乐
    [player play];
    
    return player;
}

+ (void)pauseMusicWithMusicName:(NSString *)musicName
{
    // 1.从字典中取出之前保存的播放器
    AVAudioPlayer *player = players_[musicName];
    
    // 2.判断播放器是否为空,如果不为空,则暂停
    if (player) {
        [player pause];
    }
}

+ (void)stopMusicWithMusicName:(NSString *)musicName
{
    // 1.从字典中取出之前保存的播放器
    AVAudioPlayer *player = players_[musicName];
    
    // 2.判断播放器是否为空,如果不为空,则停止音乐
    if (player) {
        [player stop];
        [players_ removeObjectForKey:musicName];
    }
}

@end












