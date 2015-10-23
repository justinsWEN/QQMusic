//
//  JWLrcScrollView.h
//  QQMusic
//
//  Created by 黄进文 on 15/10/21.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JWLrcLabel;
@interface JWLrcScrollView : UIScrollView

/** 歌词文件名 */
@property (nonatomic, copy) NSString *lrcName;

/** 当前歌曲播放的时间 */
@property (nonatomic, assign) NSTimeInterval currentTime;

/** 外面歌词Label的引用 */
@property (nonatomic, weak) JWLrcLabel *lrcLabel;

@end
