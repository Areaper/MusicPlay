//
//  MusicModel.h
//  MusicPlay
//
//  Created by lanou on 1/21/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

@property (nonatomic, copy) NSString *mp3Url;       // 音频url
@property (nonatomic, copy) NSString *ID;           // 标示符
@property (nonatomic, copy) NSString *name;         // 歌曲名称
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *blurPicUrl;   // 模糊图片
@property (nonatomic, copy) NSString *album;        // 专辑
@property (nonatomic, copy) NSString *singer;        // 歌唱者
@property (nonatomic, copy) NSString *duration;       // 时间
@property (nonatomic, copy) NSString *artists_name;    // 作曲人
@property (nonatomic, copy) NSString *lyric;          // 歌词

-(instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
