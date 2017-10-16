//
//  UIView+ZYMB.h
//  IceLand
//
//  Created by 今代科技 on 2017/4/26.
//  Copyright © 2017年 gzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYMB)


#pragma Mark -- HUD --
//- (MBProgressHUD *)HUD;
- (void)showHUD;

/**
 显示是否可以点击
 
 @param touch yes or no
 */
- (void)showHUDTouch:(BOOL)touch;


/**
 显示文本
 
 @param text 文本内容
 @param delay 延迟消失时间
 */
- (void)showHUD:(NSString *)text delay:(CGFloat)delay;


/**
 显示文本和loding(菊花转动)
 
 @param text 文本
 @param delay 延迟消失时间
 */
- (void)showHUDLoading:(NSString *)text delay:(CGFloat)delay;

/**
 显示文本带✅或者❎图片
 
 @param text 文本
 @param img -1 不显示图片 1 ✅ 0 ❎
 @param delay 延迟消失
 */
- (void)showHUD:(NSString *)text img:(NSInteger)img delay:(CGFloat)delay;
- (void)hideHud;


@end
