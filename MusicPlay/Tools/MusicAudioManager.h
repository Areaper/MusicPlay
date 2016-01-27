//
//  MusicAudioManager.h
//  MusicPlay
//
//  Created by lanou on 1/26/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayMusicVC.h"


typedef NS_ENUM(NSInteger, MusicRunMode) {
    MusicRunModeListLoop    = 0,
    MusicRunModeRandomLoop  = 1,
    MusicRunModeSingleLoop  = 2,
    MusicRunModeCurrentLoop = 3
};




// 声明代理 代理方法
@protocol MusicAudioManagerDelegate <NSObject>

- (void)audioPlayWithProgress:(float)progress;
// 代理方法 回到VC中 自动播放下一首
- (void)audioPlayEndtime;

@end


@interface MusicAudioManager : NSObject
// 对应枚举的属性 用于存储当前点击button
@property (nonatomic, assign) MusicRunMode runModel;
// 音量
@property (nonatomic, assign) float volume;
// 判断当前的状态
@property (nonatomic, assign) BOOL isPlaying;
// 代理人
@property (nonatomic, weak) id<MusicAudioManagerDelegate> delegate;

// 存储当前歌曲的URL
@property (nonatomic, strong) NSString *currentURL;

@property (nonatomic, strong) PlayMusicVC *playVC;




// 实例化单例对象
+ (instancetype)shareManager;
// 通过url设置音频
- (void)setMusicAudioWithMusicUrl:(NSString *)musicUrl;
// 播放
- (void)play;
// 暂停
- (void)pause;
// 判断当前播放的是否和重新进来的一样
- (BOOL)isplayCurrentAudioWithURL:(NSString *)url;
// 跳到指定时间播放
- (void)seekToTimePlay:(float)time;

- (NSInteger)returnCurrentTime;

@end
