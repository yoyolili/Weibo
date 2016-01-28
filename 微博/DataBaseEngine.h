//
//  DataBaseEngine.h
//  微博
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseEngine : NSObject

//保存从网络上获取的微博数据
+ (void)saveStatuses:(NSArray *)statuses;

//查询数据
+ (NSArray *)selectStatuses;

@end
