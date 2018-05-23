//
//  HKHomeNavTopView.m
//  HKHOProject
//
//  Created by hans on 2018/5/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HKHomeNavTopView.h"

@implementation HKHomeNavTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    [self addSubview:self.addressControl];
    [self addSubview:self.msgBtn];
    [self.msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KFITWIDTH(28),64));
        make.right.equalTo(self.mas_right).with.offset(-12);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    [self.addressControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.msgBtn.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom).with.offset(-3);
    }];
}
#pragma mark - interface
- (void)setupSubViewsAlpha:(CGFloat) alpha{
    self.msgBtn.alpha = self.addressControl.addressLabel.alpha = self.addressControl.titleLabel.alpha = self.addressControl.rightImageView.alpha = alpha;
}
#pragma mark - lazy load
- (HKHomeAddressControl *)addressControl{
    if (!_addressControl) {
        _addressControl = [[HKHomeAddressControl alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    }
    return _addressControl;
}
- (UIButton *)msgBtn{
    if (!_msgBtn) {
        _msgBtn = [[UIButton alloc] init];
        UIImage *image = [UIImage imageNamed:@"ic_home_message"];
        [_msgBtn setImage:image forState:UIControlStateNormal];
        [_msgBtn setTitle:@"消息" forState:UIControlStateNormal];
        _msgBtn.titleLabel.font = [UIFont systemFontOfSize:KFITFONTSIZE(9)];
        [_msgBtn setTitleColor:KRGBCOLOR(71, 71, 71) forState:UIControlStateNormal];

        _msgBtn.titleEdgeInsets = UIEdgeInsetsMake(16, -16, -25, 0);
        _msgBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 0, 0);
    }
    return _msgBtn;
}
@end


@implementation HKHomeAddressControl
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    [self setupTitleLabel];
    [self setupAddressLabel];
    [self setupRightImageView];
}
- (void)setupTitleLabel{
    [self addSubview:self.titleLabel];
    self.titleLabel.text = @"取餐: ";
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(16);
        make.bottom.equalTo(self.mas_bottom).with.offset(-8);
    }];
}
- (void)setupAddressLabel{
    [self addSubview:self.addressLabel];
    self.addressLabel.text = @"大冲商务中心A座 (1楼休息平台)";
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).with.offset(0);
        make.bottom.equalTo(self.titleLabel.mas_bottom);
    }];
}
- (void)setupRightImageView{
    [self addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).with.offset(7);
        make.centerY.equalTo(self.addressLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(8, 4));
    }];
}
#pragma mark - lazy load
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:KFITFONTSIZE(14)];
        _titleLabel.textColor = KRGBCOLOR(71, 71, 71);
    }
    return _titleLabel;
}
- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:KFITFONTSIZE(16)];
        _addressLabel.textColor = KRGBCOLOR(71, 71, 71);
    }
    return _addressLabel;
}
- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"ic_home_arrow_down"];
    }
    return _rightImageView;
}
@end
