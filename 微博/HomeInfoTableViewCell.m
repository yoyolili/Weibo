//
//  HomeInfoTableViewCell.m
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "HomeInfoTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HomeInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)bindingData:(NSDictionary *)dict
{
    [self.icon sd_setImageWithURL:dict[@"user"][@"profile_image_url"]];
    self.name.text = dict[@"user"][@"name"];
    self.time.text = dict[@"created_at"];
    self.source.text = dict[@"source"];
    self.content.text = dict[@"text"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
