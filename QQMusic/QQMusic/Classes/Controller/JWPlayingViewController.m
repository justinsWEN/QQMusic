//
//  JWPlayingViewController.m
//  QQMusic
//
//  Created by 黄进文 on 15/10/21.
//  Copyright © 2015年 黄进文. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "JWPlayingViewController.h"
#import "Masonry.h"
#import "JWMusicTool.h"
#import "JWAudioTool.h"
#import "JWMusic.h"
#import "NSString+JWExtension.h"
#import "CALayer+JWExtension.h"
#import "JWLrcScrollView.h"

#define JWColor(r,g,b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0])

@interface JWPlayingViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *albumView; // 背景图片
@property (weak, nonatomic) IBOutlet UIImageView *iconView; // 歌手封面
@property (weak, nonatomic) IBOutlet UILabel *songLabel; // 歌曲
@property (weak, nonatomic) IBOutlet UILabel *singerLabel; // 歌手
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel; // 当前时间
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel; // 歌曲总时间
@property (weak, nonatomic) IBOutlet UISlider *slider; // 进度条
@property (weak, nonatomic) IBOutlet UILabel *lrcLabel; // 歌词

/** 进度定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 播放器 */
@property (nonatomic, weak) AVAudioPlayer *player;
/** 进度定时器 */
@property (nonatomic, strong) NSTimer *progressTimer;
/** 歌词定时器 */
@property (nonatomic, strong) CADisplayLink *lrcTimer;

@property (weak, nonatomic) IBOutlet JWLrcScrollView *lrcScrollView;

@end

@implementation JWPlayingViewController

#pragma mark - 初始化数据
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、给背景图片添加毛玻璃效果
    [self setupBlurGlass];

    // 2、设置进度条滑块图片
    [self.slider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    
    // 3、开始播放音乐
    [self startPlayingMusic];
    
    // 4. 设置ScrollView
    self.lrcScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    
    
}

// 添加毛玻璃效果
- (void)setupBlurGlass {
    
    // 1、创建衣蛾UIToolBar
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    [self.albumView addSubview:toolbar];
    // 2、设置约束
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self.albumView.mas_width);
        make.height.equalTo(self.albumView.mas_height);
        make.centerX.equalTo(self.albumView.mas_centerX);
        make.centerY.equalTo(self.albumView.mas_centerY);
        // make.edges.equalTo(self.albumView);
    }];
}

// 设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

// 设置歌手图片圆角
- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    // 圆角
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
    // 边距
    self.iconView.layer.borderWidth = 5;
    self.iconView.layer.borderColor = JWColor(40, 40, 40).CGColor;
}

#pragma mark - 播放歌曲
- (void)startPlayingMusic {
    
    // 1.获取当前播放的歌曲
    JWMusic *playMusic = [JWMusicTool playingMusic];
    
    // 2.设置歌曲播放页面
    self.albumView.image = [UIImage imageNamed:playMusic.icon];
    self.iconView.image = [UIImage imageNamed:playMusic.icon];
    self.songLabel.text = playMusic.name;
    self.singerLabel.text = playMusic.singer;
    
    // 3.开始播放歌曲
    AVAudioPlayer *player = [JWAudioTool playMusicWithMusicName:playMusic.filename];
    self.currentTimeLabel.text = [NSString stringWithTime:player.currentTime];
    self.totalTimeLabel.text = [NSString stringWithTime:player.duration];
    self.player = player;
    
    // 4.设置iconView歌手图片旋转效果
    [self addIconViewAnimation];
    
    // 5.添加定时器
    [self stopProgressTimer]; // 移除之前的定时器
    [self startProgressTimer];
    
    // 6. 给lrcScrollView的lrcName设置当前播放歌曲的歌名
    self.lrcScrollView.lrcName = playMusic.lrcname;
    
    // 7. 添加歌词定时器
    [self startLrcTimer];
}

#pragma mark - 核心动画
- (void)addIconViewAnimation {
    
    // 1.创建动画
    CABasicAnimation *rotationAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 2.设置动画属性
    rotationAnima.fromValue = @(0); // 从那个位置开始旋转
    rotationAnima.toValue = @(M_PI * 2); // 旋转多少角度
    rotationAnima.duration = 40.0; // 跑一周需要的时间
    rotationAnima.repeatCount = NSIntegerMax; // 重复次数
    
    // 3.添加到iconView的layer
    [self.iconView.layer addAnimation:rotationAnima forKey:nil];
}

#pragma mark - 进度条定时器的操作
- (void)startProgressTimer {
    
    // 一开始就更新滑块的位置和当前时间
    [self updateProgress];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

- (void)updateProgress {
    
    // 设置滑块的位置
    self.slider.value = self.player.currentTime / self.player.duration;
    // 设置当前播放时间
    self.currentTimeLabel.text = [NSString stringWithTime:self.player.currentTime];
}

// 停止定时器
- (void)stopProgressTimer {
    
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

#pragma mark - 歌词定时器的操作
- (void)startLrcTimer {
    
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcInfo)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopLrcTimer {
    
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}

- (void)updateLrcInfo {
    
    self.lrcScrollView.currentTime = self.player.currentTime;
}

#pragma mark - 对进度条UISlider事件的处理

- (IBAction)sliderTouchDown {
    
    // 停掉定时器
    [self stopProgressTimer];
}

- (IBAction)sliderValueChange:(UISlider *)sender {
    
    // 1.获取当前进度条的比例
    CGFloat ratio = sender.value;
    
    // 2.根据比例计算出改变后的时间
    NSTimeInterval currentTime = self.player.duration * ratio;
    
    // 3.显示当前的时间
    self.currentTimeLabel.text = [NSString stringWithTime:currentTime];
}

- (IBAction)sliderTouchUpInside:(UISlider *)sender {
    
    // 1.改变歌曲播放进度
    // 1.1 获取当前进度条的比例
    CGFloat ratio = sender.value;
    // 1.2 根据比例计算出改变后的时间
    NSTimeInterval currentTime = self.player.duration * ratio;
    // 改变播放音乐的当前时间
    self.player.currentTime = currentTime;
    // 2.重新开启定时器
    [self startProgressTimer];
}

- (IBAction)sliderClick:(UITapGestureRecognizer *)sender {
    
    // 1. 获取进度条的比例
    // 1.1 获取用户点击的位置
    CGPoint point = [sender locationInView:sender.view];
    // 1.2 计算比例
    CGFloat ratio = point.x / self.slider.bounds.size.width;
    
    // 2. 根据比例获取点击后的播放时间
    NSTimeInterval currentTime = self.player.duration * ratio;
    // 2.1 改变当前歌曲播放进度
    self.player.currentTime = currentTime;
    // 2.2 更新进度条
    [self updateProgress];
}

#pragma mark - 对歌曲事件的处理
- (IBAction)previousMusic {
    // 播放上一首歌曲
    [self switchMusicWithNextMusic:NO];
}

- (IBAction)nextMusic {
    // 播放下一首歌曲
    [self switchMusicWithNextMusic:YES];
}

- (void)switchMusicWithNextMusic:(BOOL)isNextMusic {
    
    // 1. 获取当前播放的歌曲
    JWMusic *playMusic = [JWMusicTool playingMusic];
    // 2. 停止当前播放的歌曲
    [JWAudioTool stopMusicWithMusicName:playMusic.filename];
    // 3. 播放选择的歌曲
    JWMusic *changeMusic = nil;
    if (isNextMusic) {
        // 播放下一首歌曲
        changeMusic = [JWMusicTool nextMusic];
    }
    else {
        // 播放上一首歌曲
        changeMusic = [JWMusicTool previousMusic];
    }
    [JWAudioTool playMusicWithMusicName:changeMusic.filename];
    // 4. 将歌曲设置为当前播放歌曲
    [JWMusicTool setPlayingMusic:changeMusic];
    // 5. 播放歌曲
    [self startPlayingMusic];
}

- (IBAction)playOrPauseMusic:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    // 根据歌曲是否播放决定播放还是暂停
    if (self.player.isPlaying) {
        [self.player pause];
        // 暂定动画
        [self.iconView.layer pauseLayer];
        // 停止定时器
        [self stopProgressTimer];
    }
    else {
        [self.player play];
        // 继续动画
        [self.iconView.layer resumeLayer];
        // 启动定时器
        [self startProgressTimer];
    }
    
}

#pragma mark - <UIScrollViewDelegate>lrcView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 计算lrcView的偏移量占lrcView的宽度比例
    CGFloat offsetRatio = scrollView.contentOffset.x / scrollView.bounds.size.width;
    // 设置歌手封面的透明度
    self.iconView.alpha = 1 - offsetRatio;
    // 设置歌词label的透明度
    self.lrcLabel.alpha = 1 - offsetRatio;
    
}


@end

















