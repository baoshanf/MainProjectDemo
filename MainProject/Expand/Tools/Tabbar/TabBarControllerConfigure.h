//
//  TabBarControllerConfigure.h
//  MainProject
//
//  Created by hans on 2018/5/18.
//  Copyright © 2018年 hans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"

@interface TabBarControllerConfigure : NSObject
@property (nonatomic, readonly, strong) CYLTabBarController *tabBarController;
@property (nonatomic, copy) NSString *context;
@end
