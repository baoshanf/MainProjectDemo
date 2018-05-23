//
//  HKHomeColumnImageHeader.m
//  HKHOProject
//
//  Created by hans on 2018/5/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HKHomeColumnImageHeader.h"

@implementation HKHomeColumnImageHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KFITWIDTH(120));
    _headImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_headImgView];
}

@end
