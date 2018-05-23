//
//  ScreenAdapter.h
//  CoolFood
//
//  Created by hans on 2018/1/6.
//  Copyright © 2018年 hans. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  界面适配调用的宏
 */
/// 宽度适配
#define KFITWIDTH(width)  [[ScreenAdapter shareAdapter] fitWithWidth:width]
/// 高度适配
#define KFITHEIGHT(height) [[ScreenAdapter shareAdapter] fitWithHeight:height]
/// 字体大小适配
#define KFITFONTSIZE(a) [[ScreenAdapter shareAdapter] fitWithFontSize:a]
/// 自动缩放适配
#define KFITSCALE(a)     [[ScreenAdapter shareAdapter] fitScale:a]



// 判断是否是iPhoneX
#define KIS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// tabBar高度
#define KTAB_BAR_HEIGHT          (KIS_IPHONEX ? (49.f+34.f) : 49.f)
// 状态栏高度
#define KSTATUS_BAR_HEIGHT       (KIS_IPHONEX ? 44.f : 20.f)
// 导航栏高度
#define KNAVIGATION_BAR_HEIGHT   (KIS_IPHONEX ? 88.f : 64.f)
// 屏幕宽度
#define KSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(KSCREEN_WIDTH, KSCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(KSCREEN_WIDTH, KSCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface ScreenAdapter : NSObject
//适配UI
@property (nonatomic, assign) CGFloat fontSize;     //字体大小
@property (nonatomic, assign) CGFloat height;       //高度
@property (nonatomic, assign) CGFloat width;        //宽

@property (nonatomic, assign) CGFloat scale_width;   //宽度缩放
@property (nonatomic, assign) CGFloat scale_height; //高度缩放

@property (nonatomic, assign) CGFloat scale;        //缩放

+ (ScreenAdapter *)shareAdapter;

//字体大小适配
- (CGFloat)fitWithFontSize:(CGFloat )size;
//纵向适配(高度,Y值)
- (CGFloat)fitWithHeight:(CGFloat )height;
//横向适配(宽度,X值)
- (CGFloat)fitWithWidth:(CGFloat )width;

- (CGFloat)fitScale:(CGFloat)a;
@end
