//
//  MusicModel.m
//  MusicPlay
//
//  Created by lanou on 1/21/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "MusicModel.h"



@implementation MusicModel

//- (instancetype)initWithDic:(NSDictionary *)dic
//{
//    self = [super init];
//    if (self) {
//        [self setValuesForKeysWithDictionary:dic];
//    }
//    return self;
//}

+ (instancetype)modelWithDic:(NSDictionary *)dic
{
    MusicModel *model = [MusicModel new];
    model.mp3Url = dic[@"mp3Url"];
    model.ID = dic[@"id"];
    model.name = dic[@"name"];
    model.picUrl = dic[@"picUrl"];
    model.blurPicUrl = dic[@"blurPicUrl"];
    model.album = dic[@"album"];
    model.singer = dic[@"singer"];
    model.duration = dic[@"duration"];
    model.artists_name = dic[@"artists_name"];
    model.lyric = dic[@"lyric"];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}



@end
