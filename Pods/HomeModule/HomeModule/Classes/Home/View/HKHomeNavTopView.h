//
//  HKHomeNavTopView.h
//  HKHOProject
//
//  Created by hans on 2018/5/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HKHomeAddressControl;
@interface HKHomeNavTopView : UIView
@property (nonatomic,strong)HKHomeAddressControl *addressControl;
@property (nonatomic,strong)UIButton *msgBtn;

/**
 设置子视图alpha

 @param alpha alpha
 */
- (void)setupSubViewsAlpha:(CGFloat) alpha;
@end

@interface HKHomeAddressControl : UIControl

///标题label
@property (nonatomic,strong)UILabel *titleLabel;

///地址label
@property (nonatomic,strong)UILabel *addressLabel;

///右边imageView
@property (nonatomic,strong)UIImageView *rightImageView;

@end
