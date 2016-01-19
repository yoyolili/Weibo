//
//  NSString+StringSize.h
//  微博
//
//  Created by 阿喵 on 16/1/19.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringSize)

- (CGSize)stringSizeWithWidth:(CGFloat)width Font:(UIFont *)font;

@end
