//
//  PlayMusicVC.m
//  MusicPlay
//
//  Created by lanou on 1/25/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "PlayMusicVC.h"
#define kScreenHeight self.view.bounds.size.height
#define kScreenWidth self.view.bounds.size.width

@interface PlayMusicVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIImageView *rotateImage;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, strong) UITableView *lrcTV;
@property (nonatomic, strong) UILabel *leftTimeLabel;
@property (nonatomic, strong) UILabel *rightTimeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *singerLabel;
@property (nonatomic, strong) UISlider *timeSlider;
@property (nonatomic, strong) UIButton *lastSongBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UISlider *soundSlider;

@property (nonatomic, strong) UIButton *loopBtn;
@property (nonatomic, strong) UIButton *shuffleBtn;
@property (nonatomic, strong) UIButton *singleLoopBtn;
@property (nonatomic, strong) UIButton *musicBtn;

@property (nonatomic, strong) NSMutableArray *lrcArr;



@end

@implementation PlayMusicVC

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - delegate method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageController.currentPage = (scrollView.contentOffset.x + kScreenWidth / 2) / kScreenWidth;
}


#pragma mark - private method
- (void)drawUI
{
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.backButton];
    [self.scrollView addSubview:self.rotateImage];
    [self.view addSubview:self.pageController];
    [self.scrollView addSubview:self.lrcTV];
    [self.blurView addSubview:self.leftTimeLabel];
    [self.blurView addSubview:self.rightTimeLabel];
    [self.blurView addSubview:self.titleLabel];
    [self.blurView addSubview:self.singerLabel];
    [self.view addSubview:self.timeSlider];
    [self.blurView addSubview:self.lastSongBtn];
    [self.blurView addSubview:self.playBtn];
    [self.blurView addSubview:self.nextBtn];
    [self.blurView addSubview:self.soundSlider];
    [self.view addSubview:self.loopBtn];
    [self.view addSubview:self.shuffleBtn];
    [self.view addSubview:self.singleLoopBtn];
    [self.view addSubview:self.musicBtn];
}
#pragma mark - event response
- (void)pageControlValueChange
{
    self.scrollView.contentOffset = CGPointMake(kScreenWidth * self.pageController.currentPage, 0);
}

#pragma mark - setter and getter
- (UIImageView *)backImageView
{
    if (_backImageView == nil) {
        _backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backImageView.image = [UIImage imageNamed:@"2.jpg"];
    }
    return _backImageView;
}
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 9 * 4)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIVisualEffectView *)blurView
{
    if (_blurView == nil) {
        _blurView = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(0, kScreenHeight / 9 * 4, kScreenWidth, kScreenHeight / 9 * 5)];
        _blurView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }
    return _blurView;
}
- (UIButton *)backButton
{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _backButton.frame = CGRectMake(20, 20, 30, 30);
        [_backButton setImage:[UIImage imageNamed:@"arrowdown"] forState:UIControlStateNormal];
        _backButton.layer.cornerRadius = 30 / 2;
        _backButton.backgroundColor = [UIColor whiteColor];
        _backButton.tintColor = [UIColor blackColor];
        
    }
    return _backButton;
}
- (UIImageView *)rotateImage
{
    if (_rotateImage == nil) {
        _rotateImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - (kScreenHeight / 9 * 4 - 80)) / 2, 40, kScreenHeight / 9 * 4 - 80, kScreenHeight / 9 * 4 - 80)];
        [_rotateImage setImage:[UIImage imageNamed:@"3.jpg"]];
        _rotateImage.backgroundColor = [UIColor redColor];
        _rotateImage.layer.cornerRadius = (kScreenHeight / 9 * 4 - 80) / 2;
        _rotateImage.clipsToBounds = YES;
        _rotateImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _rotateImage.layer.borderWidth = 1.5;
    }
    return _rotateImage;
}

- (UIPageControl *)pageController
{
    if (_pageController == nil) {
        _pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight / 9 * 4 - 30, kScreenWidth, 25)];
        _pageController.numberOfPages = 2;
        _pageController.currentPage = 0;
        _pageController.backgroundColor = [UIColor clearColor];
        [_pageController addTarget:self action:@selector(pageControlValueChange) forControlEvents:UIControlEventValueChanged];
    }
    return _pageController;
}
- (UITableView *)lrcTV
{
    if (_lrcTV == nil) {
        _lrcTV = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight / 9 * 4) style:UITableViewStylePlain];
        _lrcTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _lrcTV.backgroundColor = [UIColor clearColor];
//        _lrcTV.delegate = self;
//        _lrcTV.dataSource = self;
    }
    return _lrcTV;
}
- (UILabel *)leftTimeLabel
{
    if (_leftTimeLabel == nil) {
        _leftTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 70, 20)];
        _leftTimeLabel.backgroundColor = [UIColor clearColor];
        _leftTimeLabel.text = @"-0:45";
        _leftTimeLabel.textAlignment = NSTextAlignmentCenter;
        _leftTimeLabel.textColor = [UIColor blackColor];
        _leftTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _leftTimeLabel;
}
- (UILabel *)rightTimeLabel
{
    if (_rightTimeLabel == nil) {
        _rightTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 30, 70, 20)];
        _rightTimeLabel.backgroundColor = [UIColor clearColor];
        _rightTimeLabel.textAlignment = NSTextAlignmentCenter;
        _rightTimeLabel.text = @"-3:48";
        _rightTimeLabel.textColor = [UIColor blackColor];
        _rightTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _rightTimeLabel;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 70) / 2 , 70, 70, 30)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.text = @"李白";
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (UILabel *)singerLabel
{
    if (_singerLabel == nil) {
        _singerLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 80) / 2, 110, 80, 30)];
        _singerLabel.text = @"李荣浩-模特";
        _singerLabel.textAlignment = NSTextAlignmentCenter;
        _singerLabel.textColor = [UIColor grayColor];
        _singerLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _singerLabel;
}

- (UISlider *)timeSlider
{
    if (_timeSlider == nil) {
        _timeSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, kScreenHeight / 9 * 4 - 10, kScreenWidth, 20)];
        _timeSlider.backgroundColor = [UIColor clearColor];
        [_timeSlider setThumbImage:[UIImage imageNamed:@"thumb@2x.png"] forState:UIControlStateNormal];
        _timeSlider.minimumTrackTintColor = [UIColor redColor];
        _timeSlider.value = 0.33;
    }
    return _timeSlider;
}
- (UIButton *)lastSongBtn
{
    if (_lastSongBtn == nil) {
        _lastSongBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _lastSongBtn.frame = CGRectMake(45, 150, 30, 20);
        _lastSongBtn.backgroundColor = [UIColor clearColor];
        [_lastSongBtn setImage:[[UIImage imageNamed:@"rewind.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    return _lastSongBtn;
}
- (UIButton *)playBtn
{
    if (_playBtn == nil) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _playBtn.frame = CGRectMake((kScreenWidth - 20) / 2 , 150, 20, 20);
        [_playBtn setImage:[[UIImage imageNamed:@"play.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
    }
    return _playBtn;
}
- (UIButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _nextBtn.frame = CGRectMake(kScreenWidth - 75, 150, 30, 20);
        [_nextBtn setImage:[[UIImage imageNamed:@"forward.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    return _nextBtn;
}
- (UISlider *)soundSlider
{
    if (_soundSlider == nil) {
        _soundSlider = [[UISlider alloc] initWithFrame:CGRectMake(30, 190, kScreenWidth - 60, 10)];
        _soundSlider.backgroundColor = [UIColor clearColor];
        [_soundSlider setThumbImage:[UIImage imageNamed:@"volumn_slider_thumb@2x"] forState:UIControlStateNormal];
        _soundSlider.minimumTrackTintColor = [UIColor blackColor];
        _soundSlider.maximumTrackTintColor = [UIColor blackColor];
        _soundSlider.maximumValueImage = [UIImage imageNamed:@"volumehigh@2x"];
        _soundSlider.minimumValueImage = [UIImage imageNamed:@"volumelow@2x"];
    }
    return _soundSlider;
}

- (UIButton *)loopBtn
{
    if (_loopBtn == nil) {
        _loopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _loopBtn.frame = CGRectMake(10, kScreenHeight - 50, 30, 30);
        [_loopBtn setImage:[[UIImage imageNamed:@"loop"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_loopBtn setBackgroundImage:[[UIImage imageNamed:@"loop-s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    }
    return _loopBtn;
}
- (UIButton *)shuffleBtn
{
    if (_shuffleBtn == nil) {
        _shuffleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _shuffleBtn.frame = CGRectMake(kScreenWidth - 40, kScreenHeight - 50, 30, 30);
        [_shuffleBtn setImage:[[UIImage imageNamed:@"shuffle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_shuffleBtn setBackgroundImage:[[UIImage imageNamed:@"shuffle-s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    }
    return _shuffleBtn;
}
- (UIButton *)singleLoopBtn
{
    if (_singleLoopBtn == nil) {
        _singleLoopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _singleLoopBtn.frame = CGRectMake(kScreenWidth / 3 - 5, kScreenHeight - 50, 30, 30);
        [_singleLoopBtn setImage:[[UIImage imageNamed:@"singleloop"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_singleLoopBtn setBackgroundImage:[[UIImage imageNamed:@"singleloop-s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    }
    return _singleLoopBtn;
}
- (UIButton *)musicBtn
{
    if (_musicBtn == nil) {
        _musicBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _musicBtn.frame = CGRectMake(kScreenWidth / 3 * 2 - 25, kScreenHeight - 50, 30, 30);
//        _musicBtn.highlighted = NO;
        [_musicBtn setImage:[[UIImage imageNamed:@"music"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        
        [_musicBtn setImage:[[UIImage imageNamed:@"music-s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        
        _musicBtn.adjustsImageWhenHighlighted = YES;
    }
    return _musicBtn;
}



@end
