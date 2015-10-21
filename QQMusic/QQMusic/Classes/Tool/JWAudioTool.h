//
//  JWAudioTool.h
//  02-播放音效
//
//  Created by 黄进文 on 15/10/20.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JWAudioTool : NSObject

/**
 * 播放音效
 */
+ (void)playSoundWithSoundName:(NSString *)soundName;

/**
 * 播放音乐
 */
+ (AVAudioPlayer *)playMusicWithMusicName:(NSString *)musicName;

/**
 * 播放音乐
 */
+ (void)pauseMusicWithMusicName:(NSString *)musicName;

/**
 * 播放音乐
 */
+ (void)stopMusicWithMusicName:(NSString *)musicName;

@end
