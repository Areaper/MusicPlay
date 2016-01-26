//
//  MusicAudioManager.h
//  MusicPlay
//
//  Created by lanou on 1/26/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
// 声明代理 代理方法
@protocol MusicAudioManagerDelegate <NSObject>

- (void)audioPlayWithProgress:(float)progress;

@end


@interface MusicAudioManager : NSObject
// 音量
@property (nonatomic, assign) float volume;
// 判断当前的状态
@property (nonatomic, assign) BOOL isPlaying;
// 代理人
@property (nonatomic, weak) id<MusicAudioManagerDelegate> delegate;





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
