//
//  UINavigationController+notification.m
//  微博
//
//  Created by qingyun on 16/1/25.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "UINavigationController+notification.h"
#import "Common.h"

@implementation UINavigationController (notification)

- (void)showNotification:(NSString *)notification
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, kScreenWidth, 30)];
    label.backgroundColor = [UIColor orangeColor];
    label.text = notification;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 20;
    
    [self.view insertSubview:label belowSubview:self.navigationBar];
    
    [UIView animateWithDuration:0.25 animations:^{
        label.frame = CGRectOffset(label.frame, 0, 30);
    }completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.2 delay:1 options:0 animations:^{
            label.frame = CGRectOffset(label.frame, 0, -30);
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

@end
