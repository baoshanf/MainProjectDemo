//
//  HKHomeMenuBannerView.m
//  HKHOProject
//
//  Created by hans on 2018/5/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HKHomeMenuBannerView.h"
#import "SDCycleScrollView.h"

@interface HKHomeMenuBannerView()
@property (nonatomic,strong)SDCycleScrollView *adScrollView;
@end
@implementation HKHomeMenuBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.adScrollView];
    }
    return self;
}
#pragma mark - lazy load
- (SDCycleScrollView *)adScrollView{
    if (!_adScrollView) {
        _adScrollView = [[SDCycleScrollView alloc] initWithFrame: self.bounds];
        _adScrollView.backgroundColor = [UIColor whiteColor];
        _adScrollView.delegate = self;
        //        _adScrollView.placeholderImage = [UIImage imageNamed:@"ic_home_catg_commend_pre"];
        _adScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _adScrollView.autoScrollTimeInterval = 3.5f;
        _adScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        _adScrollView.autoScroll = YES;
        _adScrollView.localizationImageNamesGroup = @[@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2472797939,284752534&fm=27&gp=0.jpg",@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2472797939,284752534&fm=27&gp=0.jpg",@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2472797939,284752534&fm=27&gp=0.jpg"];
        _adScrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _adScrollView;
}
- (CGRect)frame{
    
    return CGRectMake(0, 0, KSCREEN_WIDTH, KFITWIDTH(170));
    
}
@end
