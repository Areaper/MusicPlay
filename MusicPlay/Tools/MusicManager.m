//
//  MusicManager.m
//  MusicPlay
//
//  Created by lanou on 1/22/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "MusicManager.h"

#import "Reachability.h"



@interface MusicManager ()
@property (nonatomic, strong) NSMutableArray *modelDataArray;

@end

@implementation MusicManager

+ (instancetype)shareManager{
    // 两种方法都可以 推荐GCD
    
    static MusicManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[MusicManager alloc] init];
        }
    });
    return manager;
    
    // 线程锁
//    @synchronized(self) {
//        if (manager == nil) {
//            manager = [[MusicManager alloc] init];
//        }
//        return manager;
//    }
}

- (void)requestDataWithBlock:(block1)block
{
    NSArray *arr = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:@"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"]];
        for (int i = 0; i < arr.count; i++) {
        MusicModel *model = [MusicModel modelWithDic:arr[i]];
        [self.modelDataArray addObject:model];
    }
    block();
}

- (NSInteger)returnModelNumber
{
    return self.modelDataArray.count;
    
}

- (MusicModel *)returnModelWithIndexpath:(NSInteger)indexPath
{
    return self.modelDataArray[indexPath];
}


#pragma mark - netWork
- (BOOL)isnetWork
{
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    BOOL isnetwork;
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"没网络");
            isnetwork = NO;
            break;
        case ReachableViaWiFi:
            //            NSLog(@"");
            
            isnetwork = YES;
            break;
        case ReachableViaWWAN:
            //            NSLog(@"没网络");
            
            isnetwork = YES;
            break;
            
        default:
            break;
    }
    return isnetwork;
}


- (NSMutableArray *)modelDataArray
{
    if (!_modelDataArray) {
        _modelDataArray = [NSMutableArray array];
    }
    return _modelDataArray;
}

@end
