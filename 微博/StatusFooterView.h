//
//  StatusFooterView.h
//  微博
//
//  Created by qingyun on 16/1/26.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusModel;

@interface StatusFooterView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *retwitter;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *like;

- (void)bindDataWithDict:(StatusModel *)model;

@end
