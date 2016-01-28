//
//  HomeInfoTableViewCell.h
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusModel;

@interface HomeInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *imageSuperView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *reContent;
@property (weak, nonatomic) IBOutlet UIView *reImageSuperView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reHeightConstraint;

- (void)bindingData:(StatusModel *)model;

@end
