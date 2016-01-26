//
//  LrcModel.h
//  MusicPlay
//
//  Created by lanou on 1/25/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcModel : NSObject
// 单例
+ (LrcModel *)shareLRC;
// 解析歌词
- (void)parserWithString:(NSString *)lrc;
// 返回歌词数量
- (NSInteger)returnLrcAmont;
// 根据索引返回歌词
- (NSString *)returnLrcWithNumber:(NSInteger)number;
// 根据时间返回索引
- (NSInteger)returnNumberWithCurrentTime:(NSInteger)currentTime;

@end
