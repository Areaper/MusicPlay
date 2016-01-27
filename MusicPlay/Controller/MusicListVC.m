//
//  MusicListVC.m
//  MusicPlay
//
//  Created by lanou on 1/21/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "MusicListVC.h"
#import "MusicCell.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "MusicModel.h"
#import "UIImageView+WebCache.h"
#import "FXBlurView.h"
#import "UIViewController+HUD.h"
#import "MusicManager.h"
#import "PlayMusicVC.h"
#import "MusicAudioManager.h"



@interface MusicListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *musicArr;

// 全局的  被选择的index
@property (nonatomic, assign) NSInteger selectIndex;


@end

@implementation MusicListVC





#pragma mark - lifeCircle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    
    self.selectIndex = [MusicManager shareManager].changeIndex;
    MusicManager *mm = [MusicManager shareManager];
    if (mm.returnModelNumber) {
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[[MusicManager shareManager] returnModelWithIndexpath:_selectIndex].blurPicUrl]];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"音乐播放器";
    
    // 设置 backImageView的fram
    self.backImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // visual 光学的 视觉的
//    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithFrame:self.view.bounds];
    
    // blur模糊的
//    visualView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    [self.backImageView addSubview:visualView];

    // 三方实现毛玻璃效果
    FXBlurView *fxView = [[FXBlurView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    fxView.dynamic = YES;
    fxView.blurRadius = 40;
    fxView.tintColor = [UIColor clearColor];
    
    // 设置上边导航bar为透明
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // rightBarButtonItem 使用自定义button
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setImage:[UIImage imageNamed:@"music-s"] forState:UIControlStateNormal];
    [customBtn setImage:[UIImage imageNamed:@"music-s"] forState:UIControlStateHighlighted];
    [customBtn addTarget:self action:@selector(RightBtnTapHandle) forControlEvents:UIControlEventTouchUpInside];
    customBtn.frame = CGRectMake(0, 0, 30, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
    
    
    // 设置tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    
    // 背景图片作为 tableView的背景图片
    self.tableView.backgroundView = self.backImageView;
    
    // 加上毛玻璃效果
    [self.backImageView addSubview:fxView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // 这个属性控制背景是否向四周延伸
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 下面这句话的作用: 当有导航的时候 00 点 顶着导航 2.没有导航的时候是顶着屏幕的00点
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    
    
    // 不要横线 全部分割线隐藏
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 或者 下面这句只是把多余的分割线隐藏掉
//    self.tableView.tableFooterView = [UIView new];  // 在cell不够铺满整个屏幕的时候有效
    
    // 注册
    [self.tableView registerClass:[MusicCell class] forCellReuseIdentifier:@"reuse"];

    

    // 管理歌曲的单例
    MusicManager *manager = [MusicManager shareManager];
    [manager requestDataWithBlock:^{  // 相当于单例的初始化方法   在其中请求网络
        
        
        [self.tableView reloadData];  // 在反调block中更新tableView
        
    } withViewController:self];  // 将试图控制器对象传入单例对象进行控制
    
    
    // 获取通知中心  添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectIndexNotifiHandle:) name:@"selectedIndex" object:nil];
    
}

// 观察者方法
- (void)selectIndexNotifiHandle:(NSNotification *)notifi
{
    _selectIndex = [notifi.object integerValue];  // 获取当前播放歌曲的index
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[[MusicManager shareManager] returnModelWithIndexpath:_selectIndex].picUrl]];  // 根据index 更换背景图片
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - event response

- (void)RightBtnTapHandle
{
    PlayMusicVC *playMusicVC = [MusicAudioManager shareManager].playVC;  // 获取当前播放歌曲的详情页面
    playMusicVC.currentIndex = self.selectIndex;  // 更新index
    playMusicVC.music = [[MusicManager shareManager] returnModelWithIndexpath:self.selectIndex];  // 更新model
    [self presentViewController:playMusicVC animated:YES completion:nil];  // 模态推出详情页面
}


#pragma mark - dataSource  TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[MusicManager shareManager] returnModelNumber];  // 通过单例返回歌曲数量
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    [cell cellWithModel:[[MusicManager shareManager] returnModelWithIndexpath:indexPath.row]];  // 通过单例返回对应model
    cell.backgroundColor = [UIColor clearColor]; // 设置背景为透明
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[[[MusicManager shareManager] returnModelWithIndexpath:indexPath.row] blurPicUrl]]];  // 点击更换背景图片
    // 点击之后 会有一个灰色渐变效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // 当点击就是播放页面, 同时播放器单例对应的页面不为空
    if (self.selectIndex == indexPath.row && [MusicAudioManager shareManager].playVC) {
        [self presentViewController:[MusicAudioManager shareManager].playVC animated:YES completion:nil];
    }
    else
    {
        
        // 否则初始化一个页面
        PlayMusicVC *playMusicVC = [[PlayMusicVC alloc] init];
        MusicManager *musicManager = [MusicManager shareManager];
        playMusicVC.music = [musicManager returnModelWithIndexpath:indexPath.row];
        playMusicVC.currentIndex = indexPath.row;
        [self presentViewController:playMusicVC animated:YES completion:nil];
    }
    
    
    // 使用block进行传值
    
//    playMusicVC.block = ^(NSInteger index) {
//        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[[[MusicManager shareManager] returnModelWithIndexpath:index] blurPicUrl]]];
//    };
    
    
    
}


#pragma mark - setter and getter
- (NSMutableArray *)musicArr
{
    if (!_musicArr) {
        _musicArr = [NSMutableArray array];
    }
    return _musicArr;
}




@end
