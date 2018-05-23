//
//  ScreenAdapter.m
//  CoolFood
//
//  Created by hans on 2018/1/6.
//  Copyright © 2018年 hans. All rights reserved.
//

#import "ScreenAdapter.h"

#define DWIDTH  375             //设计时使用宽度
#define DHEIGHT 667             //设计时使用高度

static ScreenAdapter *_screenAdapter = nil;

@implementation ScreenAdapter
+ (ScreenAdapter *)shareAdapter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _screenAdapter = [[self alloc] init];
    });
    return _screenAdapter;
}

- (instancetype)init {
    self =  [super init];
    if (self) {
        
        self.fontSize = [UIFont systemFontSize];
        self.width = 375.f;
        self.height = 667.f;
        
    }
    
    return self;
}

- (CGFloat)scale_width
{
    CGFloat width = DWIDTH;
    
    if (IS_IPHONE_4_OR_LESS) {
        width = 320;
    }else if (IS_IPHONE_5){
        width = 320;
    }else if (IS_IPHONE_6){
        width = 375;
    }else if (IS_IPHONE_6P){
        width = 414;
    }else if (IS_IPAD)
    {
        width = 768;
    }else if (KIS_IPHONEX){
        width = 375;
    }
    
    CGFloat scale = width / DWIDTH;
    
    return scale;
    
}

- (CGFloat)scale_height {
    CGFloat height = DHEIGHT;
    if (IS_IPHONE_4_OR_LESS) {
        height = 480;
    }else if (IS_IPHONE_5){
        height = 568;
    }else if (IS_IPHONE_6){
        height = 667;
    }else if (IS_IPHONE_6P){
        height = 736;
    }else if (IS_IPAD)
    {
        height = 1024;
    }else if (KIS_IPHONEX){
        height = 812 - 24;
    }
    
    CGFloat scale = height / DHEIGHT;
    
    return scale;
}

- (CGFloat)scale {
    
    return self.scale_width < self.scale_height ? self.scale_width : self.scale_height;
    
}

//字体大小适配
- (CGFloat)fitWithFontSize:(CGFloat )size
{
    
    if (IS_IPAD) {
        
        return size * 1.25;
        
    }else if (IS_IPHONE_4_OR_LESS)
    {
        return size;
    }
    
    return size * self.scale;
}
//高度适配
- (CGFloat)fitWithHeight:(CGFloat )height
{
    
    return height * self.scale_height;
}
//宽度适配
- (CGFloat)fitWithWidth:(CGFloat )width
{
    return width * self.scale_width;
}

- (CGFloat)fitScale:(CGFloat)a
{
    return self.scale * a;
}
@end
