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



@interface MusicListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *musicArr;

@end

@implementation MusicListVC

#pragma mark - setter and getter

- (NSMutableArray *)musicArr
{
    if (!_musicArr) {
        _musicArr = [NSMutableArray array];
    }
    return _musicArr;
}

#pragma mark - lifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"音乐播放器";
    
//    UISlider
    
    
    
    // 设置背景图片
    self.backImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    backImage.image = [UIImage imageNamed:@"1"];
    
    // visual 光学的 视觉的
//    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithFrame:self.view.bounds];
    
    // blur模糊的
//    visualView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    [self.backImageView addSubview:visualView];


    FXBlurView *fxView = [[FXBlurView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    fxView.dynamic = YES;
    fxView.blurRadius = 40;
    fxView.tintColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setImage:[UIImage imageNamed:@"music-s"] forState:UIControlStateNormal];
    [customBtn setImage:[UIImage imageNamed:@"music-s"] forState:UIControlStateHighlighted];
    [customBtn addTarget:self action:@selector(RightBtnTapHandle) forControlEvents:UIControlEventTouchUpInside];
    customBtn.frame = CGRectMake(0, 0, 30, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundView = self.backImageView;
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
//    self.tableView.tableFooterView = [UIView new];
    
    // 注册
    [self.tableView registerClass:[MusicCell class] forCellReuseIdentifier:@"reuse"];

    

    
    MusicManager *manager = [MusicManager shareManager];
    [manager requestDataWithBlock:^{
        
        
        [self.tableView reloadData];
        
    } withViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - event response

- (void)RightBtnTapHandle
{
//    PlayMusicVC *playMusicVC = [[PlayMusicVC alloc] init];
//    [self presentViewController:playMusicVC animated:YES completion:nil];
//

}


#pragma mark - dataSource  TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[MusicManager shareManager] returnModelNumber];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    [cell cellWithModel:[[MusicManager shareManager] returnModelWithIndexpath:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[[[MusicManager shareManager] returnModelWithIndexpath:indexPath.row] blurPicUrl]]];
    // 点击之后 会有一个灰色渐变效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayMusicVC *playMusicVC = [[PlayMusicVC alloc] init];
    MusicManager *musicManager = [MusicManager shareManager];
    playMusicVC.music = [musicManager returnModelWithIndexpath:indexPath.row];
    playMusicVC.currentIndex = indexPath.row;
    
    playMusicVC.block = ^(NSInteger index) {
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[[[MusicManager shareManager] returnModelWithIndexpath:index] blurPicUrl]]];
    };
    [self presentViewController:playMusicVC animated:YES completion:nil];
    
    
}





@end
