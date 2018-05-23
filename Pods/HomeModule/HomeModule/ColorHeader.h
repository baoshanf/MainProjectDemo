//
//  ColorHeader.h
//  HomeModule
//
//  Created by hans on 2018/5/18.
//  Copyright © 2018年 hans. All rights reserved.
//

#ifndef ColorHeader_h
#define ColorHeader_h

#define KRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define KRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define KHEXCOLOR(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

// 控制器view背景色
#define KBackGroundColor KRGBCOLOR(247, 246, 249)

#endif /* ColorHeader_h */
