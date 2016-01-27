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
@property (nonatomic, strong) MusicModel *music;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) Block block;

@end
