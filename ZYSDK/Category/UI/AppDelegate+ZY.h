//
//  AppDelegate+ZY.h
//  ZYSDK
//
//  Created by guozengying on 2017/2/21.
//  Copyright © 2017年 gzy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (ZY)<UITabBarControllerDelegate>

/**
 *  初始化window
 *
 *  @return UIWindow
 */
- (UIWindow *)getWindow;
/**
 *  注册推送
 */
- (void)registerUserNotification;
/**
 *  第三方键盘监听
 */
//- (void)IQKeyBoard;
/**
 *  登录页面视图控制器成为跟视图控制器
 */
- (void)singleViewControllerWithClass:(Class)classs;
/**
 *  主页成为根数图控制器
 */
- (void)tabBarControllerWithControllers:(NSArray *)controllers darkImageNames:(NSArray *)darkImageNames lightImageNames:(NSArray *)lightImageNames tabBarNames:(NSArray *)names;
/**
 *  网络监控
 */
- (void)reachability;

@end
