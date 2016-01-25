//
//  HomeInfoTableViewCell.m
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "HomeInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@implementation HomeInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code

    self.content.preferredMaxLayoutWidth = kScreenWidth - 8 - 8;
    
    self.reContent.preferredMaxLayoutWidth = self.content.preferredMaxLayoutWidth;
}

- (void)bindingData:(NSDictionary *)dict
{
    [self.icon sd_setImageWithURL:dict[@"user"][@"profile_image_url"]];
    self.name.text = dict[@"user"][@"name"];
    self.time.text = dict[@"created_at"];
    self.source.text = dict[@"source"];
    self.content.text = dict[@"text"];
    [self layoutImages:dict[@"pic_urls"] forView:self.imageSuperView Height:self.heightConstraint];
    
    NSDictionary *reDict = dict[@"retweeted_status"];
    
    self.reContent.text = dict[@"retweeted_status"][@"text"];
    [self layoutImages:reDict[@"pic_urls"] forView:self.reImageSuperView Height:self.reHeightConstraint];
    if (reDict) {
        //当有转发微博时
        //设置imageSuperView的高估为0
        [self layoutImages:nil forView:self.imageSuperView Height:self.heightConstraint];
    }else {
        //没有转发微博
        [self layoutImages:dict[@"pic_urls"] forView:self.imageSuperView Height:self.heightConstraint];
    }
}

//根据图片的张数确定view的高度
- (CGFloat)imageSuperViewHeight:(NSInteger)count
{
    //0张
    if (count <= 0) {
        return 0;
    }
    
    //显示需要的行数
    NSInteger line = ceil(count/3.f);
    
    //计算需要显示的高度
    CGFloat height = line * 90 + (line - 1) * 5;
    
    return height;
}

- (void)layoutImages:(NSArray *)images forView:(UIView *)view Height:(NSLayoutConstraint *)heightConstraint;
{
    //移走子视图
    NSArray *array = view.subviews;
    [array makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //根据图片显示需要的高度调整view的高度的约束
    CGFloat height = [self imageSuperViewHeight:images.count];
    heightConstraint.constant = height;
    
    //添加图片
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *imgUrl = [obj objectForKey:@"thumbnail_pic"];
        
        //创建imageview
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((idx % 3 * (90 + 5)), (idx / 3 * (90 + 5)), 90, 90)];
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
//        UIImage *image = [UIImage imageWithData:data];
//        imageView.image = image;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        
        [view addSubview:imageView];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
