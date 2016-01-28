//
//  HomeInfoTableViewCell.m
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "HomeInfoTableViewCell.h"
#import "Common.h"

@interface HomeInfoTableViewCell ()<SDPhotoBrowserDelegate>

@end

@implementation HomeInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code

    self.content.preferredMaxLayoutWidth = kScreenWidth - 8 - 8;
    
    self.reContent.preferredMaxLayoutWidth = self.content.preferredMaxLayoutWidth;
}

- (void)bindingData:(StatusModel *)model
{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.user.profile_image_url]];
    self.name.text = model.user.screen_name;
    self.time.text = model.timeAgo;
    self.source.text = model.source;
    self.content.text = model.text;
//    [self layoutImages:dict[@"pic_urls"] forView:self.imageSuperView Height:self.heightConstraint];
    
    StatusModel *reModel = model.retweeted_status;
    
    self.reContent.text = reModel.text;
    [self layoutImages:reModel.pic_urls forView:self.reImageSuperView Height:self.reHeightConstraint];
    if (reModel) {
        //当有转发微博时
        //设置imageSuperView的高估为0
        [self layoutImages:nil forView:self.imageSuperView Height:self.heightConstraint];
    }else {
        //没有转发微博
        [self layoutImages:model.pic_urls forView:self.imageSuperView Height:self.heightConstraint];
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
        UIButton *imageView = [[UIButton alloc] initWithFrame:CGRectMake((idx % 3 * (90 + 5)), (idx / 3 * (90 + 5)), 90, 90)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] forState:UIControlStateNormal];
        //点击时显示大图
        [imageView addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
        imageView.tag = idx;
        
        [view addSubview:imageView];
    }];
}
//图片点击事件
- (void)showImage:(UIButton *)sender
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = sender.superview;//父视图
    browser.imageCount = sender.superview.subviews.count;
    browser.currentImageIndex = (int)sender.tag;
    browser.delegate = self;
    [browser show];
}

#pragma mark - photo browser delegate
//返回的临时小图
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIView *superView;
    if (self.imageSuperView.subviews.count != 0) {
        superView = self.imageSuperView;
    }else{
        superView = self.reImageSuperView;
    }
    //找到响应的btn
    UIButton *btn = superView.subviews[index];
    
    return [btn imageForState:UIControlStateNormal];
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    UIView *superView;
    if (self.imageSuperView.subviews.count != 0) {
        superView = self.imageSuperView;
    }else{
        superView = self.reImageSuperView;
    }
    //找到响应的btn
    UIButton *btn = superView.subviews[index];
    //缩略图时的url
    NSString *str = [btn sd_imageURLForState:UIControlStateNormal].absoluteString;
    //大图时的url
    str = [str stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:str];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
