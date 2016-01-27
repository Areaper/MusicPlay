//
//  PlayMusicVC.h
//  MusicPlay
//
//  Created by lanou on 1/25/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

typedef void(^Block)(NSInteger);

@interface PlayMusicVC : UIViewController
// 当前页面的model
@property (nonatomic, strong) MusicModel *music;

// 当前页面播放歌曲的索引
@property (nonatomic, assign) NSInteger currentIndex;

// 用于页面传值
//@property (nonatomic, copy) Block block;

@end
