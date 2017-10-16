//
//  UIView+ZY.m
//  ZY_DayDayNews
//
//  Created by guozengying on 2017/2/23.
//  Copyright © 2017年 gzy. All rights reserved.
//

#import "UIView+ZY.h"

@implementation UIView (ZY)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (UIView * (^)(CGFloat x))setX
{
    return ^(CGFloat x) {
        self.x = x;
        return self;
    };
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)radius {
    return self.layer.cornerRadius;
}

- (void)setRadius:(CGFloat)radius {
    if (radius <= 0) {
        radius = self.width * 0.5f;
    }
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 2.f;
    
}
- (UIView *(^)(UIColor *color)) setColor
{
    return ^ (UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGRect frame)) setFrame
{
    return ^ (CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGSize size)) setSize
{
    return ^ (CGSize size) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        return self;
    };
}

- (UIView *(^)(CGPoint point)) setCenter
{
    return ^ (CGPoint point) {
        self.center = point;
        return self;
    };
}

- (UIView *(^)(NSInteger tag)) setTag
{
    return ^ (NSInteger tag) {
        self.tag = tag;
        return self;
    };
}

- (void)addTarget:(id)target
           action:(SEL)action;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

//- (void)addBorderColor:(UIColor *)color{
//    [self.layer setBorderColor:color.CGColor];
//    [self.layer setBorderWidth:0.5];
//    [self.layer setCornerRadius:4];
//}

- (void)addBorderColor:(UIColor *)color radius:(CGFloat)radius isDottedLine:(BOOL)isDottedLine{
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
  
    if (isDottedLine) {
        //再次赋值的时候把之前设置的边框去掉
        //        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0.0000001;
        CAShapeLayer * borderLayer = [CAShapeLayer layer];
        borderLayer.bounds = self.bounds;
        borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:radius].CGPath;
        //        borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
        borderLayer.lineWidth = 0.5;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
//        borderLayer.strokeColor = [UIColor colorWithHexString:@"#333333"].CGColor;
        [self.layer addSublayer:borderLayer];
        //虚线边框(数值越大，间隔越多)
        borderLayer.lineDashPattern = @[@2, @2];
    }
    else {
        for (CALayer * layer in self.layer.sublayers) {
            if ([layer isKindOfClass:[CAShapeLayer class]]) {
                [layer removeFromSuperlayer];
            }
        }
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = 0.5;
    }
}
- (void)addShadowColor:(UIColor *_Nullable)color {
    if (!color) {
        color = [UIColor blackColor];
    }
    self.layer.shadowColor = color.CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.layer.shadowRadius = 5;//阴影半径，默认3
    self.layer.masksToBounds = NO;
//    self.layer.shadowPath = [UIBezierPath  bezierPathWithRect:self.bounds].CGPath;


}
- (void)addBezierPathShadowColor:(UIColor *_Nullable)color{
    self.layer.shadowColor = color.CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.7;//阴影透明度，默认0
    self.layer.shadowRadius = 5;//阴影半径，默认3
    self.layer.masksToBounds = NO;

    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addWH = 10;
    
    CGPoint topLeft      = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];  
    //设置阴影路径  
    self.layer.shadowPath = path.CGPath;
}
- (UIViewController *)superController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (UIViewController *)findSuperViewController{
    //找到view所在的vc
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    return object;
}
//点赞放大动画
- (void)scaleAnimateWithView{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3); //放大
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformMakeScale(0.9, 0.9); //缩小
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeScale(1.0, 1.0); //正常
            } completion:^(BOOL finished) {
            }];
        }];
    }];
}
@end
