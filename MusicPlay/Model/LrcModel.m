//
//  LrcModel.m
//  MusicPlay
//
//  Created by lanou on 1/25/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "LrcModel.h"

@interface LrcModel ()

@property (nonatomic, strong) NSMutableArray *timeArr; // 歌词时间数组
@property (nonatomic, strong) NSMutableArray *lyricsArr; // 歌词数组

@end

@implementation LrcModel

+ (LrcModel *)shareLRC
{
    static LrcModel *lrcModel = nil;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        lrcModel = [[LrcModel alloc] init];
    });
    return lrcModel;
}


- (void)parserWithString:(NSString *)lrc
{
    self.timeArr = [NSMutableArray array];
    self.lyricsArr = [NSMutableArray array];

    NSArray *sentenceLrc = [lrc componentsSeparatedByString:@"\n"];
    for (NSString *string in sentenceLrc) {
        NSArray *arr = [string componentsSeparatedByString:@"]"];
        if (arr.count >= 2) {
            [self.lyricsArr addObject:arr[1]];
            NSString *lrc = [arr[0] substringFromIndex:1];
            NSArray *timeArr = [lrc componentsSeparatedByString:@":"];
            NSInteger minuteInt = [timeArr[0] intValue];
            NSInteger secondInt = [timeArr[1] intValue];
            NSInteger finalInt = minuteInt * 60 + secondInt;
            NSString *finalStr = [NSString stringWithFormat:@"%li", (long)finalInt];
            
            [self.timeArr addObject:finalStr];
            
        }
        
    }
}
- (NSInteger)returnLrcAmont
{
    return self.lyricsArr.count;
}
- (NSString *)returnLrcWithNumber:(NSInteger)number
{
    return self.lyricsArr[number];
}
- (NSInteger)returnNumberWithCurrentTime:(NSInteger)currentTime
{
    for (int i = 0; i < self.timeArr.count; i++) {
        NSInteger time = [self.timeArr[i] intValue];
        if (time == currentTime) {
            return i;
        }
    }
    return 0;
}



@end
