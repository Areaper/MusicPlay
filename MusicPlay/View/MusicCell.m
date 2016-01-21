//
//  MusicCell.m
//  MusicPlay
//
//  Created by lanou on 1/21/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "MusicCell.h"
#import "UIImageView+WebCache.h"


@interface MusicCell ()


@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *musicNamelabel;
@property (nonatomic, strong) UILabel *singerNameLabel;

@end

@implementation MusicCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        
//    }
//    return self;
//}
- (UIImageView *)picImageView
{
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 55, 55)];
        [self.contentView addSubview:self.picImageView];
        
    }
    return _picImageView;
}

- (UILabel *)musicNamelabel
{
    if (!_musicNamelabel) {
        _musicNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame)+10, 10, [UIScreen mainScreen].bounds.size.width - 85, 21)];
        _musicNamelabel.highlightedTextColor = [UIColor redColor];
        _musicNamelabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.musicNamelabel];
    }
    return _musicNamelabel;
}
- (UILabel *)singerNameLabel
{
    if (!_singerNameLabel) {
        _singerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame)+10, CGRectGetMaxY(self.musicNamelabel.frame)+3, [UIScreen mainScreen].bounds.size.width - 85, 21)];
        _singerNameLabel.font = [UIFont systemFontOfSize:13];
        _singerNameLabel.textColor = [UIColor grayColor];
        _singerNameLabel.highlightedTextColor = [UIColor redColor];
        _singerNameLabel.textColor = [UIColor whiteColor];
//        _singerNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.singerNameLabel];
    }
    return _singerNameLabel;
}




- (void)cellWithModel:(MusicModel *)model
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    self.musicNamelabel.text = model.name;
    self.singerNameLabel.text = model.singer;
 
}


@end
