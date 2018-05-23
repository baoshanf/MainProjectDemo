//
//  HomeMenuViewController.m
//  HomeModule
//
//  Created by hans on 2018/5/18.
//  Copyright © 2018年 hans. All rights reserved.
//

#import "HomeMenuViewController.h"
#import <LazyScroll/LazyScroll.h>
#import "HKHomeMenuBannerView.h"
#import "HKHomeColumnCycleView.h"
@interface HomeMenuViewController ()<TMLazyScrollViewDataSource,UIScrollViewDelegate>
///整体页面
@property (nonatomic,strong) TMLazyScrollView *scrollView;
///每个元素坐标
@property (nonatomic,strong) NSMutableArray *rects;
@end

@implementation HomeMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:self.scrollView];
    for (NSInteger i = 0; i < 20; i ++) {
        if (i == 0) {
            [self.rects addObject: [NSValue valueWithCGRect:CGRectMake(10, 0, KSCREEN_WIDTH - 20, KFITWIDTH(170))]];
            
        }else if (i == 1){
            [self.rects addObject:[NSValue valueWithCGRect:CGRectMake(0, CGRectGetMaxY([[self.rects lastObject] CGRectValue]), KSCREEN_WIDTH, KFITWIDTH(390))]];
        } else{
            [self.rects addObject:[NSValue valueWithCGRect:CGRectMake(10, CGRectGetMaxY([self.rects[i - 1] CGRectValue]) + 5,CGRectGetWidth(self.scrollView.frame) - 20, 80 - 3)]];
        }
    }
    
    CGRect rect = [[self.rects lastObject] CGRectValue];
    self.scrollView.contentSize = CGSizeMake(rect.size.width,CGRectGetMaxY(rect));
    
    [self.scrollView reloadData];
}
#pragma mark - TMMuiLazyScrollViewDataSource
/**
 Similar with 'tableView:numberOfRowsInSection:' of UITableView.
 */
- (NSUInteger)numberOfItemsInScrollView:(nonnull TMLazyScrollView *)scrollView{
    return self.rects.count;
}

/**
 Similar with 'tableView:heightForRowAtIndexPath:' of UITableView.
 Manager the correct muiID of item views will bring a higher performance.
 */
- (nonnull TMLazyItemModel *)scrollView:(nonnull TMLazyScrollView *)scrollView
                       itemModelAtIndex:(NSUInteger)index{
    TMLazyItemModel *model = [[TMLazyItemModel alloc] init];
    model.absRect = [self.rects[index] CGRectValue];
    model.muiID = [NSString stringWithFormat:@"%lu",(unsigned long)index];
    return model;
}

/**
 Similar with 'tableView:cellForRowAtIndexPath:' of UITableView.
 It will use muiID in item model instead of index.
 */
- (nonnull UIView *)scrollView:(nonnull TMLazyScrollView *)scrollView
                   itemByMuiID:(nonnull NSString *)muiID{
    NSInteger index = muiID.integerValue;
    if (index == 0) {
        UIView *view = [scrollView dequeueReusableItemWithIdentifier:@"HKHomeMenuBannerView"];
        if (!view) {
            view = [[HKHomeMenuBannerView alloc] initWithFrame:[self.rects[index] CGRectValue]];
            view.reuseIdentifier = @"HKHomeMenuBannerView";
        }
        return view;
    }else if(index == 1){
        UIView *view = [scrollView dequeueReusableItemWithIdentifier:@"HKHomeColumnCycleView"];
        if (!view) {
            view = [[HKHomeColumnCycleView alloc] initWithFrame:[self.rects[index] CGRectValue]];
            view.restorationIdentifier = @"HKHomeColumnCycleView";
        }
        return view;
    }else{
        
        UIView *view = [scrollView dequeueReusableItemWithIdentifier:@"testView"];
        if (!view) {
            
            view = [[UIView alloc] init];
            view.reuseIdentifier = @"testView";
            view.backgroundColor = KRGBCOLOR(arc4random()%255, arc4random()%255, arc4random()%255);
        }
        
        CGRect rect = [self.rects[index] CGRectValue];
        view.frame = rect;
        return view;
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.scrollDelegate respondsToSelector:@selector(homeMenuScrollViewDidScroll:)]) {
        [self.scrollDelegate homeMenuScrollViewDidScroll:scrollView];
    }
}
#pragma mark - lazy load
- (TMLazyScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[TMLazyScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, self.view.frame.size.height - KNAVIGATION_BAR_HEIGHT - KTAB_BAR_HEIGHT)];
        _scrollView.dataSource = self;
        _scrollView.delegate = self;
        _scrollView.autoAddSubview = YES;
        _scrollView.showsVerticalScrollIndicator = YES;
    }
    return _scrollView;
}
- (NSMutableArray *)rects{
    if (!_rects) {
        _rects = [[NSMutableArray alloc] init];
    }
    return _rects;
}

@end
