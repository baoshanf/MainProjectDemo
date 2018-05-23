//
//  HKMenuScrollview.h
//  HKHOProject
//
//  Created by hans on 2018/5/10.
//  Copyright © 2018年 hans. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HKMenuScrollViewDelegate <NSObject>

/**
 scrollView 滑到的index
 */
- (void)contentScrollViewIndex:(NSInteger) index;

@end

typedef void(^TitleStyleBlock)(UIColor **norColor,UIColor **selColor,UIColor **backgroundColor,UIFont **titleFont,UIFont **titleSelFont,CGFloat *titleMargin,CGFloat *titleScrollViewHeight,UIColor **sliderColor,CGFloat *sliderHeight,CGFloat *titleWidth,CGFloat *firstTitleMargin);

@interface HKMenuScrollView : UIView
///内容滚动视图
@property (nonatomic,strong)UIScrollView *contentScrollView;

///头部滚动视图
@property (nonatomic,strong)UIScrollView *titleScrollView;

///代理
@property (nonatomic,weak)id<HKMenuScrollViewDelegate> delegate;

/**
 构造函数
 
 @param frame frame
 @param vc bind vc
 @param titleStyleBlock titleStyleBlock
 @return self
 */
- (instancetype)initWithFrame:(CGRect) frame
                   Controller:(UIViewController *) vc
                       images:(NSArray<NSString *> *)images
              titleStyleBlock:(TitleStyleBlock) titleStyleBlock;

/**
 滑动到指定位置
 */
- (void)scrollToIndex:(NSInteger) index;

/**
 顶部图片缩放
 
 @param scale 缩放比例
 */
- (void)setupImageViewTransform:(CGFloat) scale;
@end
