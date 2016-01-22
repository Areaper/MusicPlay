//
//  MusicManager.h
//  MusicPlay
//
//  Created by lanou on 1/22/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicModel.h"
typedef void(^block1)(void);


@interface MusicManager : NSObject
// 实例化一个单例对象
+ (instancetype)shareManager;
// 请求网络
- (void)requestDataWithBlock:(block1)block;
// 返回元素个数
- (NSInteger)returnModelNumber;
// 根据indexPath返回model

-(MusicModel *)returnModelWithIndexpath:(NSInteger)indexPath;


@end
