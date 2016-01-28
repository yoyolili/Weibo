//
//  StatusFooterView.m
//  微博
//
//  Created by qingyun on 16/1/26.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "StatusFooterView.h"
#import "Common.h"
#import "StatusModel.h"

@implementation StatusFooterView

- (void)awakeFromNib
{
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
}

- (void)bindDataWithDict:(StatusModel *)model
{
    [self.retwitter setTitle:[model.reposts_count stringValue]forState:UIControlStateNormal];
    [self.comment setTitle:[model.comments_count stringValue]forState:UIControlStateNormal];
    [self.like setTitle:[model.attitudes_count stringValue] forState:UIControlStateNormal];
}

@end
