//
//  UIView+ZY.h
//  ZY_DayDayNews
//
//  Created by guozengying on 2017/2/23.
//  Copyright © 2017年 gzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZY)

/**
 *  1.间隔X值
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  2.间隔Y值
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  3.宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  4.高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  5.中心点X值
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  6.中心点Y值
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  7.尺寸大小
 */
@property (nonatomic, assign) CGSize size;

/**
 *  8.起始点
 */
@property (nonatomic, assign) CGPoint origin;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;


@property (nonatomic, assign) CGFloat radius;

/**
 添加边框, 宽度为2
 */
@property (nonatomic, strong) UIColor * _Nonnull borderColor;

/**
 添加边框

 @param color 边框颜色
 @param radius 圆角大小
 @param isDottedLine 是否为虚线
 */
- (void)addBorderColor:(UIColor * _Nonnull)color radius:(CGFloat)radius isDottedLine:(BOOL)isDottedLine;

/**
 *  2.UIView 的点击事件
 *
 *  @param target   目标
 *  @param action   事件
 */

- (void)addTarget:(id _Nonnull)target
           action:(SEL _Nonnull)action;

/**
 添加shadow
 
 @param color color
 */
- (void)addShadowColor:(UIColor *_Nullable)color;
- (void)addBezierPathShadowColor:(UIColor *_Nullable)color;

// 找到view所在的视图控制器
- (UIViewController *_Nullable)superController;
- (UIViewController *_Nullable)findSuperViewController;
//点赞放大动画
-(void)scaleAnimateWithView;

@end
