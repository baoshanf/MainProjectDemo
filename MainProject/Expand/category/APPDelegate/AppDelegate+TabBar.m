//
//  AppDelegate+TabBar.m
//  MainProject
//
//  Created by hans on 2018/5/18.
//  Copyright © 2018年 hans. All rights reserved.
//

#import "AppDelegate+TabBar.h"
#import "TabBarControllerConfigure.h"
@interface AppDelegate ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate>


@end
@implementation AppDelegate (TabBar)
#pragma mark - //初始tabbar
- (void)tabBarConfig {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TabBarControllerConfigure *tabBarControllerConfig = [[TabBarControllerConfigure alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    [self.window setRootViewController:tabBarController];
    tabBarController.delegate = self;
    [self.window makeKeyAndVisible];
}

#pragma mark - //CYLTabBarControllerDelegate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    if ([control cyl_isTabButton]) {
        animationView = [control cyl_tabImageView];
    }
    
    //动画
    [self addScaleAnimationOnView:animationView repeatCount:1];
}
#pragma clang diagnostic pop

#pragma mark - //缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}
@end
