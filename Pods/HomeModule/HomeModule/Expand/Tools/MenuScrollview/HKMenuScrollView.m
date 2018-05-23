//
//  HKMenuScrollview.m
//  HKHOProject
//
//  Created by hans on 2018/5/10.
//  Copyright © 2018年 hans. All rights reserved.
//

#import "HKMenuScrollView.h"
#import "UIView+Frame.h"

@interface HKMenuScrollView ()<UIScrollViewDelegate>{
    
    BOOL _isClickTitle; //记录是否点击title切换
    CGFloat _lastOffsetX; //记录上一次的offsetX
}

///绑定的vc
@property (nonatomic,strong)UIViewController *bindVc;

///titleHeight
@property (nonatomic,assign)CGFloat titleHeight;
///头部视图高
@property (nonatomic,assign)CGFloat titleScrollViewHeight;
///normalColor
@property (nonatomic,strong)UIColor *norColor;
///selectColor
@property (nonatomic,strong)UIColor *selColor;

///titleFont
@property (nonatomic,strong)UIFont *titleFont;

///titleSelFont
@property (nonatomic,strong)UIFont *titleSelFont;

///titleWidths
@property (nonatomic,strong)NSMutableArray *titleWidths;

///titleLabels
@property (nonatomic,strong)NSMutableArray *titleLabels;

///title间隙
@property (nonatomic,assign)CGFloat titleMargin;

///底部滚条
@property (nonatomic,strong)UIView *underLine;

@property (nonatomic,strong)UIColor *underLineColor;
//底部underlineHeight
@property (nonatomic,assign)CGFloat underLineHeight;
@property (nonatomic,assign)CGFloat csTitleWidth;
@property (nonatomic,assign)CGFloat firstTitleMargin;

///图片数组
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,strong)NSMutableArray *imageViews;
@end
@implementation HKMenuScrollView

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSStringFromClass([self class]) reason:@"must use initWithFrame:Controller:titleStyleBlock: instead" userInfo:nil];
}

- (instancetype)initWithFrame:(CGRect) frame
                   Controller:(UIViewController *) vc
                       images:(NSArray<NSString *> *)images
              titleStyleBlock:(TitleStyleBlock)titleStyleBlock{
    self = [super initWithFrame:frame];
    if (self) {
        _bindVc = vc;
        _images = images;
        //必须声明局部变量，block释放后局部变量随形参释放
        UIColor *norColor;
        UIColor *selColor;
        UIColor *backgroundColor;
        UIFont *titleFont;
        UIFont *titleSelFont;
        UIColor *sliderColor;
        
        if (titleStyleBlock) {
            //指向形参地址对应
            titleStyleBlock(&norColor,&selColor,&backgroundColor,&titleFont,&titleSelFont,&_titleMargin,&_titleScrollViewHeight,&sliderColor,&_underLineHeight,&_csTitleWidth,&_firstTitleMargin);
            
            if (norColor) self.norColor = norColor;
            
            if (selColor) self.selColor = selColor;
            
            if (backgroundColor) self.titleScrollView.backgroundColor = backgroundColor;
            
            if (titleFont) self.titleFont = titleFont;
            if (titleSelFont) self.titleSelFont = titleSelFont;
            if (sliderColor) self.underLineColor = sliderColor;
        }
        [self setupView];
    }
    return self;
}

/**
 滑动到指定位置
 */
- (void)scrollToIndex:(NSInteger) index{
    _isClickTitle = YES;
    [self selectLabel:self.titleLabels[index]];
    CGFloat offsetX = index * self.bounds.size.width;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    //记录上一次的偏移量
    _lastOffsetX = offsetX;
    
    //点击事件处理完成
    _isClickTitle = NO;
    //触发代理
    if ([self.delegate respondsToSelector:@selector(contentScrollViewIndex:)]) {
        [self.delegate contentScrollViewIndex:index];
    }
    
}

#pragma setup view
- (void)setupView{
    [self setupChildView];
    [self setUpTitleWidth];
    [self setupAllTitle];
}

/**
 设置content子页面
 */
- (void)setupChildView{
    
    for (NSInteger i = 0; i < _bindVc.childViewControllers.count; i ++) {
        //        [self.contentScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UIViewController *vc = _bindVc.childViewControllers[i];
        [vc.view removeFromSuperview];
        vc.view.frame = CGRectMake(i * self.contentScrollView.bounds.size.width, 0, self.contentScrollView.width, self.contentScrollView.height);
        
        [self.contentScrollView addSubview:vc.view];
    }
}

/**
 设置标题
 */
- (void)setupAllTitle{
    NSUInteger count = _bindVc.childViewControllers.count;
    //添加所有标题
    CGFloat labelWidth = 0;
    CGFloat labelHeight =  KFITWIDTH(22);//self.titleScrollViewHeight - self.underLineHeight;
    CGFloat labelX = 0;
    CGFloat labelY =  CGRectGetMaxY(self.titleScrollView.frame) - self.underLineHeight - 3 - labelHeight;
    
    
    for (NSInteger i = 0; i < count; i ++) {
        UIViewController *vc = _bindVc.childViewControllers[i];
        UILabel * label = [[UILabel alloc] init];
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        //tag值
        label.tag = i;
        label.textColor = self.norColor;
        label.font = self.titleFont;
        //按钮标题
        label.text = vc.title;
        labelWidth = [self.titleWidths[i] floatValue];
        //按钮位置
        UILabel *lastLabel = [self.titleLabels lastObject];
        labelX = i == 0 ?  self.firstTitleMargin: self.titleMargin + CGRectGetMaxX(lastLabel.frame);
        label.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, labelY - 3-KFITWIDTH(28), KFITWIDTH(28), KFITWIDTH(28))];
        img.centerX = label.centerX;
        img.image = [UIImage imageNamed:self.images[i]];
        img.tag = 100 + i;
        [self.imageViews addObject:img];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        if (i == 0) {
            //开始时触发
            [self titleClick:tap];
        }
        
        
        //保存
        [self.titleLabels addObject:label];
        [self.titleScrollView addSubview:label];
        [self.titleScrollView addSubview:img];
    }
    
    //设置标题滚动视图的内容范围
    UILabel *lastLabel = self.titleLabels.lastObject;
    self.titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    
}
#pragma mark - action
- (void)setupImageViewTransform:(CGFloat) scale{
    //获取现在选中的tab下标
    NSInteger selectIndex = _lastOffsetX / self.bounds.size.width;
    
    for (NSInteger i = 0; i < self.imageViews.count; i ++) {
        UIImageView *img = self.imageViews[i];
        img.transform = CGAffineTransformMakeScale(scale,scale);
        
        if (i == selectIndex) {
            //将选中的图片放大到1.3倍
            if (scale == 1) {
                img.transform = CGAffineTransformMakeScale(1.3,1.3);
            }
        }
        //颜色跟着渐变
        img.alpha = scale;
    }
    self.titleScrollView.backgroundColor = [KRGBCOLOR(252, 230, 83) colorWithAlphaComponent:1 - scale];
}
/**
 label点击事件
 */
- (void)titleClick:(UITapGestureRecognizer *)sender{
    //记录是否点击标题
    _isClickTitle = YES;
    //获取对应标题label
    UILabel *label = (UILabel *)sender.view;
    
    //获取当前角标
    NSInteger i = label.tag;
    
    //选中label
    [self selectLabel:label];
    
    //内容滚动到对应位置
    CGFloat offsetX = i * self.bounds.size.width;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    //记录上一次的偏移量
    _lastOffsetX = offsetX;
    
    //点击事件处理完成
    _isClickTitle = NO;
    //触发代理
    if ([self.delegate respondsToSelector:@selector(contentScrollViewIndex:)]) {
        [self.delegate contentScrollViewIndex:i];
    }
}

/**
 选中label
 */
- (void)selectLabel:(UILabel *)label{
    
    //将未选中的label换回normal颜色,放大效果
    for (UILabel *labelView in self.titleLabels) {
        if (label != labelView) {
            labelView.textColor = self.norColor;
            labelView.font = self.titleFont;
        }
    }
    label.font = self.titleSelFont;
    label.textColor = self.selColor;
    //计算title宽度
    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleSelFont} context:nil];
    CGFloat width = titleBounds.size.width;
    label.width = width;
    [self setLabelTitleCenter:label];
    [self setUpUnderLine:label];
    //控制图片大小
    UIImageView *img = [self.titleScrollView viewWithTag:(label.tag + 100)];
    [self setUpImageView:img];
}

/**
 设置underLine
 */
- (void)setUpUnderLine:(UILabel *)label{
    // 获取文字尺寸
    //    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    CGFloat underLineHeigt = self.underLineHeight;
    self.underLine.y = self.titleScrollViewHeight - underLineHeigt;
    self.underLine.height = underLineHeigt;
    //最开始不需要动画
    if (self.underLine.x == 0) {
        self.underLine.width = label.width;//titleBounds.size.width;
        self.underLine.x = label.x;
        return;
    }
    //点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.width = label.width;//titleBounds.size.width;
        self.underLine.x = label.x;
    }];
}
- (void)setUpImageView:(UIImageView *)imageView{
    
    CGAffineTransform form = imageView.transform;
    if (form.a < 1.0f || form.d < 1.0f) {
        //缩放时不做改变
        return;
    }
    imageView.transform = CGAffineTransformMakeScale(1.3,1.3);
    for (UIImageView *imgView in self.imageViews) {
        if (imageView != imgView) {
            imgView.transform = CGAffineTransformMakeScale(1,1);
        }
    }
}
#pragma mark - private method
/**
 *  计算标题宽度
 */
-(void)setUpTitleWidth{
    //    NSUInteger count = _bindVc.childViewControllers.count;
    NSArray *titles = [_bindVc.childViewControllers valueForKeyPath:@"title"];
    
    CGFloat totalWidth = 0;
    
    //计算所有标题的宽度
    for (NSString *title in titles) {
        
        //处理空title
        if ([title isKindOfClass:[NSNull class]]) {
            NSException *excp = [NSException exceptionWithName:NSStringFromClass([self class]) reason:@"childViewController.title 不能为空" userInfo:nil];
            [excp raise];
        }
        //计算title宽度
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
        CGFloat width = titleBounds.size.width;
        //保存
        [self.titleWidths addObject:@(width > _csTitleWidth ? width : _csTitleWidth)];
        totalWidth += width;
    }
    
    //    CGFloat titleMargin = (self.bounds.size.width - totalWidth) / (count + 1);
    //    titleMargin = titleMargin > 34 ? 34 : titleMargin;
    //取最大值
    //    _titleMargin = titleMargin < self.titleMargin ? self.titleMargin : titleMargin;
    
}

/**
 设置下标偏移
 */
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel{
    
    if (_isClickTitle) {
        //避免重复点击
        return;
    }
    //获取两个标题中心点距离
    CGFloat centerDelta = rightLabel.x - leftLabel.x;
    
    //标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLabel:rightLabel leftLabel:leftLabel];
    
    //获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    //计算当前下划线偏移量
    CGFloat underLineTransFormX = offsetDelta * centerDelta / self.bounds.size.width;
    
    //宽度递增偏移量
    CGFloat underLineWidth = offsetDelta * widthDelta / self.bounds.size.width;
    
    self.underLine.width += underLineWidth;
    self.underLine.x += underLineTransFormX;
}
/**
 获取两个标题按钮宽度差值
 */
- (CGFloat)widthDeltaWithRightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    CGRect titleBoundsR = [rightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    CGRect titleBoundsL = [leftLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    return titleBoundsR.size.width - titleBoundsL.size.width;
}

/**
 设置标题滚动
 
 @param label 选中label
 */
- (void)setLabelTitleCenter:(UILabel *)label{
    //设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - self.bounds.size.width/2;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - self.bounds.size.width + self.titleMargin;
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    //偏移
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
#pragma mark - UIScrollViewDelegate
/**
 正在滑动
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    //获取左边角标
    NSInteger leftIndex = offsetX / self.bounds.size.width;
    //左边按钮
    UILabel *leftLabel = self.titleLabels[leftIndex];
    
    //右边角标
    NSUInteger rightIndex = leftIndex + 1;
    //右边按钮
    UILabel *rightLabel = nil;
    if (rightIndex < self.titleLabels.count) {
        rightLabel = self.titleLabels[rightIndex];
    }
    //下标偏移
    [self setUpUnderLineOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    _lastOffsetX = offsetX;
}
/**
 减速完成
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger i = offsetX / self.bounds.size.width;
    
    [self selectLabel:self.titleLabels[i]];
    
    //i改变，触发delegate
    if ([self.delegate respondsToSelector:@selector(contentScrollViewIndex:)]) {
        [self.delegate contentScrollViewIndex:i];
    }
}

#pragma mark -  lazy load
- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), self.bounds.size.width, self.bounds.size.height - CGRectGetHeight(self.titleScrollView.frame))];
        _contentScrollView.contentSize = CGSizeMake(self.bounds.size.width * _bindVc.childViewControllers.count, self.bounds.size.height - CGRectGetHeight(self.titleScrollView.frame));
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentScrollView];
        
        
    }
    return _contentScrollView;
}

- (UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.backgroundColor = [UIColor orangeColor];
        _titleScrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.titleScrollViewHeight);
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_titleScrollView];
    }
    return _titleScrollView;
}

- (CGFloat)titleHeight{
    if (!_titleHeight) {
        _titleHeight = 44;
    }
    return _titleHeight;
}

- (UIColor *)norColor{
    if (!_norColor) {
        _norColor = [UIColor blackColor];
    }
    return _norColor;
}

- (UIColor *)selColor{
    if (!_selColor) {
        _selColor = [UIColor redColor];
    }
    return _selColor;
}

-(UIFont *)titleFont{
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:15];
    }
    return _titleFont;
}
- (UIFont *)titleSelFont{
    if (!_titleSelFont) {
        _titleSelFont = [UIFont systemFontOfSize:15];
    }
    return _titleSelFont;
}
- (NSMutableArray *)titleWidths{
    if (!_titleWidths) {
        _titleWidths = [[NSMutableArray alloc] init];
    }
    return _titleWidths;
}

- (NSMutableArray *)titleLabels{
    if (!_titleLabels) {
        _titleLabels = [[NSMutableArray alloc] init];
    }
    return _titleLabels;
}

- (UIView *)underLine{
    if (!_underLine) {
        _underLine = [[UIView alloc] init];
        _underLine.backgroundColor = self.underLineColor;
        [self.titleScrollView addSubview:_underLine];
    }
    return _underLine;
}

- (CGFloat)underLineHeight{
    if (!_underLineHeight) {
        _underLineHeight = 3;
    }
    return _underLineHeight;
}
- (NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}

@end
