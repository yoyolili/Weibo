//
//  NSString+Documents.m
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "NSString+Documents.h"
#import "Common.h"

@implementation NSString (Documents)

//返回文件在Documents目录下的路径
+ (NSString *)documentsFilePath:(NSString *)fileName
{
    //归档
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    return filePath;
}

@end
