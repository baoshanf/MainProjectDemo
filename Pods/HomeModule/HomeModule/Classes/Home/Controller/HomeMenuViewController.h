//
//  HomeMenuViewController.h
//  HomeModule
//
//  Created by hans on 2018/5/18.
//  Copyright © 2018年 hans. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeMenuVCScrollDelegate <NSObject>
- (void)homeMenuScrollViewDidScroll:(UIScrollView *)scrollView;
@end
@interface HomeMenuViewController : UIViewController
@property (nonatomic,weak)id<HomeMenuVCScrollDelegate> scrollDelegate;
@end
