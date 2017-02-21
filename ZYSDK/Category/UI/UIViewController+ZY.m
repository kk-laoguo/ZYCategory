//
//  UIViewController+ZY.m
//  ZYSDK
//
//  Created by guozengying on 2017/2/21.
//  Copyright © 2017年 gzy. All rights reserved.
//

#import "UIViewController+ZY.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void * HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (ZY)
- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}
- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHUD{
    [self showHUD:nil touch:NO img:-1 delay:-1];
}
- (void)showHUDTouch:(BOOL)touch{
    [self showHUD:nil touch:touch img:-1 delay:-1];
}
- (void)showHUD:(NSString *)text delay:(CGFloat)delay{
    [self showHUD:text touch:YES img:-1 delay:-1];
}
- (void)showHUDLoading:(NSString *)text delay:(CGFloat)delay{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.userInteractionEnabled = YES;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.yOffset = -73.0f;
//    [HUD setOffset:CGPointMake(0, -73.0f)];
//    HUD.label.text = text;
    HUD.labelText = text;
    if (delay != -1) {
//        if (delay == 0) {
//            [HUD hideAnimated:YES afterDelay:0.618];
//        }else{
//            [HUD hideAnimated:YES afterDelay:delay];
//        }
        if (delay == 0) {
            [HUD hide:YES afterDelay:0.618];
        } else {
            [HUD hide:YES afterDelay:delay];
        }
    }
    [self setHUD:HUD];
}
- (void)showHUD:(NSString *)text img:(NSInteger)img delay:(CGFloat)delay{
    [self showHUD:text touch:YES img:img delay:delay];
}

- (void)hideHud{
//    [[self HUD] hideAnimated:YES];
    [[self HUD] hide:YES];
    [self.HUD removeFromSuperview];
}

/**
 hud
 @param text 文本
 @param touch 屏幕点击事件是否允许
 @param img -1 不显示图片 1 ✅ 0 ❎
 @param delay 延迟时间
 */
- (void)showHUD:(NSString *)text touch:(BOOL)touch img:(NSInteger)img delay:(CGFloat)delay{
//    [self.HUD hideAnimated:YES];
    [self.HUD hide:YES];
    MBProgressHUD * HUD;
    if ([self isKindOfClass:[UITableViewController class]] || [self isKindOfClass:[UICollectionView class]]) {
        HUD = [MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
    }else{
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    HUD.userInteractionEnabled = !touch;
    HUD.removeFromSuperViewOnHide = YES;
    //    HUD.yOffset = -10.0f;
    if (text) {
        HUD.mode = MBProgressHUDModeText;
//        HUD.label.text = text;
        HUD.labelText = text;

    }
    if (img != -1) {
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:(img) ? ([UIImage imageNamed:@"checkmark_success_white"]) : ([UIImage imageNamed:@"checkmark_failure_white"])];
    }
    if (delay != -1) {
//        if (delay == 0) {
//            [HUD hideAnimated:YES afterDelay:1];
//        } else {
//            [HUD hideAnimated:YES afterDelay:delay];
//        }
        if (delay == 0) {
            [HUD hide:YES afterDelay:1];
        } else {
            [HUD hide:YES afterDelay:delay];
        }
    }
    [self setHUD:HUD];
}

#pragma Mark -- 

/**
 打电话

 @param tel 号码
 */
- (void)callTelePhone:(NSString *)tel{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tel]];
    [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:^(BOOL success) {
        if (success) {
            
        }
    }];
}

@end
