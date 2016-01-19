//
//  NSString+StringSize.m
//  微博
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "NSString+StringSize.h"
#import "Common.h"

@implementation NSString (StringSize)

- (CGSize)stringSizeWithWidth:(CGFloat)width Font:(UIFont *)font
{
    CGFloat wid = width;
    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(wid, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    return rect.size;
}

@end
