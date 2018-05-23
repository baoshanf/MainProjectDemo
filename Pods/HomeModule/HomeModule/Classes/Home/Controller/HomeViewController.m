
//
//  HomeViewController.m
//  HomeModule
//
//  Created by hans on 2018/5/18.
//  Copyright © 2018年 hans. All rights reserved.
//

#import "HomeViewController.h"
#import "HKMenuScrollView.h"
#import "HomeMenuViewController.h"
#import "HKHomeNavTopView.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeMenuVCScrollDelegate,HKMenuScrollViewDelegate>


///主页面
@property (nonatomic,strong)UITableView *tableView;
///
@property (nonatomic,strong)HKMenuScrollView *menuScrollView;
///地址视图
@property (nonatomic,strong)HKHomeNavTopView *topView;
///记录之前页面的contentOffsetY
@property (nonatomic,assign)CGFloat lastOffsetY;
@end
static CGFloat ScrollHeight = 64;
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.tableView];
    [self setupTopTab];
    //解决tableview自动下移20的问题
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior =  UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}
#pragma mark - set up
- (void)setupTopTab{
    NSArray *titles = @[@"热狗",@"陈冠希",@"尼古拉斯",@"刘德华",@"hins",@"223"];
    for (NSInteger i = 0; i < titles.count; i ++) {
        HomeMenuViewController *vc = [[HomeMenuViewController alloc] init];
        vc.title = titles[i];
        vc.scrollDelegate = self;
        [self addChildViewController:vc];
        
        [self addChildViewController:vc];
    }
}
#pragma mark - HKHomeMenuVCScrollDelegate
- (void)homeMenuScrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y + self.lastOffsetY;
    //1 > scale > 0
    CGFloat scale = 1 - offsetY / ScrollHeight;
    if (offsetY < ScrollHeight) {
        if (scrollView.contentOffset.y > 0) {
            self.tableView.contentOffset = CGPointMake(0,offsetY);
        }else{
            self.lastOffsetY = 0;
            scale = 1;
            self.tableView.contentOffset = CGPointMake(0, 0);
        }
    }else{
        scale = 0;
        self.tableView.contentOffset = CGPointMake(0, ScrollHeight);
    }
    [self.menuScrollView setupImageViewTransform:scale];
    [self.topView setupSubViewsAlpha:scale];
    //设置地址栏颜色渐变
    self.topView.backgroundColor = self.menuScrollView.titleScrollView.backgroundColor;
}
#pragma mark - HKMenuScrollViewDelegate
- (void)contentScrollViewIndex:(NSInteger)index{
    self.lastOffsetY = self.tableView.contentOffset.y;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    [cell.contentView addSubview:self.menuScrollView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height - KNAVIGATION_BAR_HEIGHT + KSTATUS_BAR_HEIGHT;
}
#pragma mark - lazy load
- (HKMenuScrollView *)menuScrollView{
    if (!_menuScrollView) {
        
        _menuScrollView = [[HKMenuScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, self.view.frame.size.height - KNAVIGATION_BAR_HEIGHT + KSTATUS_BAR_HEIGHT) Controller:self images:@[@"tx.jpg",@"tx.jpg",@"tx.jpg",@"tx.jpg",@"tx.jpg",@"tx.jpg"] titleStyleBlock:^(UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *backgroundColor, UIFont *__autoreleasing *titleFont,UIFont *__autoreleasing *titleSelFont, CGFloat *titleMargin,CGFloat *titleScrollViewHeight,UIColor *__autoreleasing *sliderColor,CGFloat *sliderHeight,CGFloat *titleWidth,CGFloat *firstTitleMargin) {
            
            //在这里设置titleScrollview的样式
            *norColor = KRGBCOLOR(71, 71, 71);
            *selColor = KRGBCOLOR(71, 71, 71);
            *backgroundColor = [UIColor whiteColor];
            *titleFont = [UIFont systemFontOfSize:KFITFONTSIZE(14)];
            *titleSelFont = [UIFont boldSystemFontOfSize:KFITFONTSIZE(16)];
            *titleMargin = 34;
            *titleScrollViewHeight = KFITWIDTH(64.0f);
            *sliderColor = KRGBCOLOR(71, 71, 71);
            *sliderHeight = 3.0f;
            *titleWidth = 0;
            *firstTitleMargin = 20;
            
        }];
        
        _menuScrollView.delegate = (id)self;
        [_menuScrollView scrollToIndex:0];
    }
    return _menuScrollView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableHeaderView = self.topView;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = _tableView.estimatedSectionFooterHeight = _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.bounces = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}
- (HKHomeNavTopView *)topView{
    if (!_topView) {
        _topView = [[HKHomeNavTopView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), KNAVIGATION_BAR_HEIGHT)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
@end
