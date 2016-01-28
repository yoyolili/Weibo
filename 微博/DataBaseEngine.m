//
//  DataBaseEngine.m
//  微博
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "DataBaseEngine.h"
#import "Common.h"
#import "FMDatabaseAdditions.h"


@implementation DataBaseEngine
//定义静态变量确定调用一次
static NSArray *statusColumns;

//初始化方法
+ (void)initialize
{
    if (self == [DataBaseEngine class]) {
        //将db拷贝到documents目录下
        [self copyFileToDocuments];
        statusColumns = [self tableColumn:kTableName];
    }
}

+ (void)copyFileToDocuments
{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"status" ofType:@"db"];
    NSString *destPath = [NSString documentsFilePath:kDBName];
    NSError *error;
    //判断Documents文件是否存在
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:destPath]) {
        [manager copyItemAtPath:sourcePath toPath:destPath error:&error];
    }
    
}

+ (void)saveStatuses:(NSArray *)statuses
{
    //创建数据库操作队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[NSString documentsFilePath:kDBName]];
    
    //插入操作
    [queue inDatabase:^(FMDatabase *db) {
       [statuses enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           NSDictionary *dict = obj;
           /*
            *sql语句
            *1、查询出table的column，字典的所有字段，并且查找出子集
            *2、拼接sql语句
            *3、筛选出可用的字典，字典中值的类型，OC对象(NSArray、NSDictionary)转换成二进制数据
            *4、执行插入
            */
           
           //1.
           NSArray *allKey = dict.allKeys;
           //2.
           NSArray *contentKey = [self contentBetween2Array:allKey and:statusColumns];
           //根据共有的key,拼接sql语句
           NSString *sqlStr = [self sqlStringWithColumn:contentKey];
           //3.
           NSMutableDictionary *muStatus = [NSMutableDictionary dictionary];
           [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               if ([contentKey containsObject:key]) {
                   //处理对象
                   if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
                       obj = [NSKeyedArchiver archivedDataWithRootObject:obj];
                   }
                   //排除null对象
                   if (![contentKey isKindOfClass:[NSNull class]]) {
                       [muStatus setObject:obj forKey:key];
                   }
               }
           }];
           //4.
           [db executeUpdate:sqlStr withParameterDictionary:muStatus];
       }];
    }];
}
//查询数据
+ (NSArray *)selectStatuses
{
    //1.创建数据库对象
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString documentsFilePath:kDBName]];
    [db open];
    
    NSString *sqlStr = @"select * from status order by id desc limit 20";
    FMResultSet *result = [db executeQuery:sqlStr];
    
    NSMutableArray *statuses = [NSMutableArray array];
    while ([result next]) {
        //将查询的记录转化成字典
        NSDictionary *dict = [result resultDictionary];
        NSMutableDictionary *muStatus = [NSMutableDictionary dictionary];
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSData class]]) {
                obj = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
            }
            if (![obj isKindOfClass:[NSNull class]]) {
                [muStatus setObject:obj forKey:key];
            }
        }];
        //转模型
        StatusModel *model = [[StatusModel alloc] initWithDict:muStatus];
        [statuses addObject:model];
    }

    return statuses;
}
//查询所有的column
+ (NSArray *)tableColumn:(NSString *)tableName
{
    //创建db
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString documentsFilePath:kDBName]];
    [db open];
    //查询表结构schema
    FMResultSet *result = [db getTableSchema:tableName];

    NSMutableArray *columns = [NSMutableArray array];
    while ([result next]) {
        //从结果中取出字段的名字
        NSString *column = [result objectForColumnName:@"name"];
        [columns addObject:column];
    }
    return columns;
}
//找到两个数组的交集
+ (NSArray *)contentBetween2Array:(NSArray *)array1 and:(NSArray *)array2
{
    NSMutableArray *result = [NSMutableArray array];
    [array1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //如果array1中的对象obj，array2也包含，则为两者的交集
        if ([array2 containsObject:obj]) {
            [result addObject:obj];
        }
    }];
    return result;
}
//拼接sql语句
+ (NSString *)sqlStringWithColumn:(NSArray *)columns
{
    //insert into tableName (a, b, c) values (:a, :b, :c)
    NSString *column = [columns componentsJoinedByString:@", "];
    NSString *value = [columns componentsJoinedByString:@", :"];
    
    value = [@":" stringByAppendingString:value];
    
    return [NSString stringWithFormat:@"insert into %@ (%@) values(%@)",kTableName, column, value];
}

@end
