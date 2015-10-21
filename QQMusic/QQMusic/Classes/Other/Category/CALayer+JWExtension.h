//
//  CALayer+JWExtension.h
//  QQMusic
//
//  Created by 黄进文 on 15/10/21.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (JWExtension)

/** 停止动画 */
- (void)pauseLayer;

/** 继续动画 */
- (void)resumeLayer;

@end
