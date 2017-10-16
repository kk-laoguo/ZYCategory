//
//  ZYConst.h
//  ZYSDK
//
//  Created by guozengying on 2017/2/21.
//  Copyright © 2017年 gzy. All rights reserved.
//

#ifndef ZYConst_h
#define ZYConst_h

//NSLog宏
#ifdef DEBUG //处于开发阶段
#define NSLog(...) NSLog(@"%s %d\n %@\n\n", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else //处于发布阶段
#define NSLog(...)
#endif

//我需要导入的东西😝😝😝😝😝😝😝😝😝😝😝😝😝😝😝😝😝
#ifdef __OBJC__
//basic frame 😅
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//category
#import "AppDelegate+ZY.h"
#import "CALayer+ZY.h"
#import "UIButton+ZY.h"
#import "UIImage+ZY.h"
#import "UIViewController+ZY.h"
#import "NSDate+ZY.h"
#import "NSString+ZY.h"

//tool

//view
#endif
//导入的头文件😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘


// window
#define WINDOW [UIApplication sharedApplication].keyWindow
// alertView
#define mAlertView(title, msg,cancelMsg,confirmMsg) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelMsg otherButtonTitles:confirmMsg, nil]; [alert show];

#define zAlertView(title, msg,cancelMsg,confirmMsg,index) \
UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelMsg otherButtonTitles:confirmMsg, nil];alert.tag = index;[alert show];

#define certainAlertView(title, msg) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]; [alert show];

// NSUserDefaults
#define  USERDEF  [NSUserDefaults standardUserDefaults]


// frame
#define ZYWidth [UIScreen mainScreen].bounds.size.width
#define ZYHeight [UIScreen mainScreen].bounds.size.height
#define Scale_Width (MAINSCREEN_WIDTH/375.0)
#define Scale_Height (MAINSCREEN_HEIGHT/667.0)

//弱引用申明
#define WSELF __weak __typeof(self) weakSelf = self;

// 字符串
#define ZYStr(x) ([NSString stringWithFormat:@"%@", (x)])



// 是否为iOS9,获得系统版本
#define ZYIOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

// 是否为iOS7,获得系统版本
#define ZYIOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 是否为iOS8,获得系统版本
#define ZYIOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
// 是否为iOS6,获得系统版本
#define ZYIOS6 ([[UIDevice currentDevice].systemVersion doubleValue] <= 6.1)

#define iPhone4_Screen (ZYHeight == 480 ? 1 : 0)
#define iPhone6_Screen (ZYWidth == 375 ? 1 : 0)
#define iPhone6Plus_Screen (ZYWidth == 414 ? 1 : 0)

















#endif /* ZYConst_h */
