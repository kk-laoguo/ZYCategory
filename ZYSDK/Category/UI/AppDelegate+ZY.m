//
//  AppDelegate+ZY.m
//  ZYSDK
//
//  Created by guozengying on 2017/2/21.
//  Copyright © 2017年 gzy. All rights reserved.
//

#import "AppDelegate+ZY.h"

@implementation AppDelegate (ZY)

- (UIWindow *)getWindow {
    return [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

#pragma mark -
#pragma mark - 用户通知(推送)自定义方法

- (void)registerUserNotification {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound |UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else {
        // ios7注册推送通知
        //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
        //         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

/**
 *  登录页面视图控制器成为跟视图控制器
 */
- (void)singleViewControllerWithClass:(Class)classs {
    UIViewController *vc = [[classs alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIWindow *window = self.window;
    window.rootViewController = nav;
}
/**
 *  主页成为根数图控制器
 */
- (void)tabBarControllerWithControllers:(NSArray *)controllers darkImageNames:(NSArray *)darkImageNames lightImageNames:(NSArray *)lightImageNames tabBarNames:(NSArray *)names {
    UIWindow *window = self.window;
    window.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i < controllers.count; i ++) {
        //图标
        UIImage * image1 = [UIImage imageNamed:lightImageNames[i]];
        image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage * image2 = [UIImage imageNamed:darkImageNames[i]];
        image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIViewController *vc = [[[controllers [i] class] alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.title = names[i];
        [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
        nav.tabBarItem.image = image2;
        nav.tabBarItem.selectedImage = image1;
        
        nav.tabBarItem.image = [nav.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [nav.tabBarItem setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"ProximaNova-Semibold" size:0.0],NSFontAttributeName,nil]forState:UIControlStateSelected];
        [array addObject:nav];
    }
    // 创建 tabBar
    UITabBarController * tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = array;
    tabBarController.view.backgroundColor = [UIColor whiteColor];
    tabBarController.delegate = self;
    [UITabBar appearance].translucent = NO;
    
    UITabBar * tabBar = tabBarController.tabBar;
    for (UITabBarItem * item in tabBar.items) {
        item.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
    
    //改变tabbar 线条颜色
//    CGRect rect = CGRectMake(0, 0, MAINSCREEN_WIDTH, 0.5);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context,
//                                   LINE_COLOR.CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [tabBarController.tabBar setShadowImage:img];
//    [tabBarController.tabBar setBackgroundImage:[[UIImage alloc]init]];
    // 递交跟视图控制器
    window.rootViewController = tabBarController;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    // [viewController.tabBarItem.title isEqualToString:@"我的"]
    UINavigationController * nav = (UINavigationController *)viewController;
//    if ([nav.viewControllers[0] isKindOfClass:[InformationBaseViewController class]]) {
//        if (!ISLOGIN) {
//            LoginViewController * vc = [[LoginViewController alloc] init];
//            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            nav.navigationBar.barTintColor = WHITE_COLOR;
//            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
//            return NO;
//        }
//    }
//    if ([nav.viewControllers[0] isKindOfClass:[WealthViewController class]]) {
//        if (!ISLOGIN) {
//            LoginViewController * vc = [[LoginViewController alloc] init];
//            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            nav.navigationBar.barTintColor = WHITE_COLOR;
//            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
//            return NO;
//        }
//        WealthViewController * vc = [[WealthViewController alloc] init];
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
//        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
//        return NO;
//    }
    return YES;
}

//- (UINavigationController *)setNavWithVC:(UIViewController *)vc{
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f],NSForegroundColorAttributeName:BLACKTEXT_COLOR}];
//    UIImageView *navBarHairlineImageView;
//    navBarHairlineImageView = [self findHairlineImageViewUnder:nav.navigationBar];
//    navBarHairlineImageView.hidden = YES;
//    UIImageView *navLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63.5, MAINSCREEN_WIDTH, 0.5)];
//    navLine.backgroundColor = LINE_COLOR;
//    [nav.view addSubview:navLine];
//    vc.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//
//    return nav;
//}

/**
 *  网络监测
 */
//- (void)reachability {
//    // 检测网络连接状态
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    // 连接状态回调处理
//    /* AFNetworking的Block内使用self须改为weakSelf, 避免循环强引用, 无法释放 */
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//                case AFNetworkReachabilityStatusUnknown:
//                // 回调处理 未知
//                [CommonMethods setValue:@"1" key:NETWORKINGSTATE];
//                break;
//                case AFNetworkReachabilityStatusNotReachable:
//                // 回调处理 无网络
//                [CommonMethods setValue:@"1" key:NETWORKINGSTATE];
//                break;
//                case AFNetworkReachabilityStatusReachableViaWWAN:
//                // 回调处理 蜂窝网络
//                [CommonMethods setValue:@"0" key:NETWORKINGSTATE];
//                break;
//                case AFNetworkReachabilityStatusReachableViaWiFi:
//                // 回调处理 WiFi网络
//                [CommonMethods setValue:@"0" key:NETWORKINGSTATE];
//                break;
//            default:
//                break;
//        }
//    }];
//}

@end
