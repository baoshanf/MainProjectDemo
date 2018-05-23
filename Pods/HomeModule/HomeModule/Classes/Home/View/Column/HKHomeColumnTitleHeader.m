//
//  HKHomeColumnTitleHeader.m
//  HKHOProject
//
//  Created by hans on 2018/5/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HKHomeColumnTitleHeader.h"

@interface HKHomeColumnTitleHeader()
///左边
@property (nonatomic,strong)UIImageView *leftImageView;

///右边
@property (nonatomic,strong)UIImageView *rightImageView;

///标题
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation HKHomeColumnTitleHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KFITWIDTH(62));
    [self setupTitleLabel];
    [self setupLeftImageView];
    [self setupRightImageView];
}
- (void)setupTitleLabel{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
}
- (void)setupLeftImageView{
    [self addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel.mas_left).with.offset(24);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KFITWIDTH(20), KFITWIDTH(16)));
    }];
}
- (void)setupRightImageView{
    [self addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).with.offset(24);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KFITWIDTH(20), KFITWIDTH(16)));
    }];
}
#pragma mark - lazy load
- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}
- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:KFITFONTSIZE(16)];
        _titleLabel.textColor = KRGBCOLOR(71, 71, 71);
    }
    return _titleLabel;
}
@end
