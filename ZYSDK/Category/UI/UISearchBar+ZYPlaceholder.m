//
//  UISearchBar+ZYPlaceholder.m
//  IceLand
//
//  Created by 今代科技 on 2017/6/21.
//  Copyright © 2017年 gzy. All rights reserved.
//

#import "UISearchBar+ZYPlaceholder.h"

@implementation UISearchBar (ZYPlaceholder)
- (void)changeLeftPlaceholder:(NSString *)placeholder {
    self.placeholder = placeholder;
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}
- (void)setUpCancleButton{
    self.showsCancelButton = YES;
    for(id cc in [self.subviews[0] subviews])//看着一行不同
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            btn.enabled = YES;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}
@end
