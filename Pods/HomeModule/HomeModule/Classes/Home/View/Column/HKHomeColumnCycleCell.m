//
//  HKHomeColumnCycleCell.m
//  HKHOProject
//
//  Created by hans on 2018/5/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HKHomeColumnCycleCell.h"


@interface HKHomeColumnCycleCell()
///
@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *originalPriceLabel;
@property (nonatomic,strong)UILabel *salePriceLabel;
///背景阴影view
@property (nonatomic,strong)UIView *bgView;
@end
@implementation HKHomeColumnCycleCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    [self setupBgView];
    [self setupGoodsImgView];
    [self setupNameLabel];
    [self setupOriginalPriceLabel];
    [self setupSalePriceLabel];
}
- (void)setupBgView{
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-60);
    }];
}
- (void)setupGoodsImgView{
    [self.bgView addSubview:self.goodsImgView];
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.equalTo(self.bgView.mas_left).with.offset(68);
        make.right.equalTo(self.bgView.mas_right).with.offset(-68);
        make.height.equalTo(self.goodsImgView.mas_width);
    }];
}
- (void)setupNameLabel{
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImgView.mas_bottom).with.offset(20);
        make.left.right.mas_equalTo(8);
    }];
}
- (void)setupOriginalPriceLabel{
    [self.bgView addSubview:self.originalPriceLabel];
    [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(3);
        make.centerX.equalTo(self.bgView.mas_centerX);
    }];
}
- (void)setupSalePriceLabel{
    [self.bgView addSubview:self.salePriceLabel];
    [self.salePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.originalPriceLabel.mas_bottom).with.offset(3);
        make.left.right.mas_equalTo(8);
    }];
}
#pragma mark - lazy load
- (UIImageView *)goodsImgView{
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc] init];
        _goodsImgView.backgroundColor = [UIColor redColor];
    }
    return _goodsImgView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc ] init];
        _nameLabel.textColor = KRGBACOLOR(71, 71, 71, 1);
        _nameLabel.font = [UIFont boldSystemFontOfSize:KFITFONTSIZE(18)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"大保健药物";
        
    }
    return _nameLabel;
}
- (UILabel *)originalPriceLabel{
    if (!_originalPriceLabel) {
        _originalPriceLabel = [[UILabel alloc] init];
        _originalPriceLabel.font = [UIFont systemFontOfSize:KFITFONTSIZE(12)];
        _originalPriceLabel.textColor = KRGBACOLOR(51, 51, 51, 0.2);
        _originalPriceLabel.textAlignment = NSTextAlignmentCenter;
        _originalPriceLabel.text = @"￥20.33";
    }
    return _originalPriceLabel;
}
- (UILabel *)salePriceLabel{
    if (!_salePriceLabel) {
        _salePriceLabel = [[UILabel alloc] init];
        _salePriceLabel.font = [UIFont systemFontOfSize:KFITFONTSIZE(20)];
        _salePriceLabel.textColor = KRGBCOLOR(238, 112, 95);
        _salePriceLabel.textAlignment = NSTextAlignmentCenter;
        _salePriceLabel.text = @"￥13.50";
    }
    return _salePriceLabel;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 8.0f;
        _bgView.layer.shadowColor = [KRGBACOLOR(71, 71, 71, 0.1) CGColor];
        _bgView.layer.shadowOpacity = 1;
        _bgView.layer.shadowRadius = 10.0f;
        _bgView.layer.shadowOffset = CGSizeMake(5, 5);
    }
    return _bgView;
}
@end
