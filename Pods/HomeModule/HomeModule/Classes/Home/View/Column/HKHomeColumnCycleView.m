//
//  HKHomeColumnCycleView.m
//  HKHOProject
//
//  Created by hans on 2018/5/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HKHomeColumnCycleView.h"
#import "SDCycleScrollView.h"
#import "HKHomeColumnCycleCell.h"

@interface HKHomeColumnCycleView()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)SDCycleScrollView *sdCycleScrollView;
@end

@implementation HKHomeColumnCycleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.sdCycleScrollView];
    }
    return self;
}

- (SDCycleScrollView *)sdCycleScrollView{
    if (!_sdCycleScrollView) {
        _sdCycleScrollView = [[SDCycleScrollView alloc]initWithFrame:self.bounds] ;
        _sdCycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _sdCycleScrollView.autoScroll = NO;
        _sdCycleScrollView.delegate = self;
        _sdCycleScrollView.currentPageDotColor = KRGBCOLOR(252, 230, 83);
        _sdCycleScrollView.pageDotColor = KRGBCOLOR(216, 216, 216);
        _sdCycleScrollView.backgroundColor = [UIColor whiteColor];
        _sdCycleScrollView.localizationImageNamesGroup = @[@"",@"",@"",@""];
    }
    return _sdCycleScrollView;
}
#pragma mark - SDCycleScrollViewDelegate
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
    if (view != self.sdCycleScrollView) {
        return nil;
    }
    return [HKHomeColumnCycleCell class];
}
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
//    HKHomeColumnCycleCell *cycle = (HKHomeColumnCycleCell *)cell;
    
}
@end
