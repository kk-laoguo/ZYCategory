//
//  CALayer+ZY.h
//  ZYSDK
//
//  Created by guozengying on 2017/2/21.
//  Copyright © 2017年 gzy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

/**
 *  反转方向
 */
typedef NS_ENUM(NSInteger, AnimReverDirection) {
    //X
    AnimReverDirectionX = 0,
    
    //Y
    AnimReverDirectionY,
    
    //Z
    AnimReverDirectionZ,
    
};
@interface CALayer (ZY)

/**
 *  颤抖效果
 */
- (CAAnimation *)shakeFunction;

/**
 *  渐显效果
 */
- (CATransition *)fadeFunction;

/**
 *  渐显效果 效果时间
 */
- (CATransition *)fadeFunction:(CGFloat)time;

/**
 *  缩放效果
 */
- (CAKeyframeAnimation *)transformScaleFunction;

/**
 *  简3D动画吧
 */
- (CAAnimation *)anim_revers:(AnimReverDirection)direction duration:(NSTimeInterval)duration isReverse:(BOOL)isReverse repeatCount:(NSUInteger)repeatCount;

@end
