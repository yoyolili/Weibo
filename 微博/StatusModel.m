//
//  StatusModel.m
//  微博
//
//  Created by qingyun on 16/1/26.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "StatusModel.h"
#import "Common.h"
#import "UserModel.h"

@implementation StatusModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //设置属性
        
        NSString *dateString = dict[kStatusCreateTime];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        /*EEE-星期几的简写 MMM-第几月 dd-第几日
         *HH:mm:ss-时分秒 zzz-指定GMT失去的编写 yyyy-完整的年份
         *Wed Jan 27 22:23:26 +0800 2016
         */
        dateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
        //设置区域语言 en_US-美国
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSDate *date = [dateFormatter dateFromString:dateString];
       
        self.created_at = date;
        self.statusID = dict[kStatusID];
        self.text = dict[kStatusText];
        self.source = [self sourceFromHTML:dict[kStatusSource]];
        NSDictionary *userInfo = dict[kStatusUserInfo];
        self.user = [[UserModel alloc] initWithDict:userInfo];
        NSDictionary *reStatus = dict[kStatusRetweetStatus];
        if (reStatus) {
            self.retweeted_status = [[StatusModel alloc] initWithDict:reStatus];
        }
        self.reposts_count = dict[kStatusRepostsCount];
        self.comments_count = dict[kStatusCommentsCount];
        self.attitudes_count = dict[kStatusAttitudesCount];
        self.pic_urls = dict[kStatusPicUrls];
        
    }
    return self;
}
//解析source的html语句
- (NSString *)sourceFromHTML:(NSString *)html
{
//    <a href=\"http://app.weibo.com/t/feed/4fuyNj\" rel=\"nofollow\">\U5373\U523b\U7b14\U8bb0</a>"
    
    //进行筛选，当html不存在或者为空时
    if (!html || [html isKindOfClass:[NSNull class]] || [html isEqualToString:@""]) {
        return nil;
    }
    
    //定义正则表达式
    NSString *regExStr = @">.*<";//解析字符串，以>开始，以<结束，中间是任意个数、任意字符
    NSError *error;
    //初始化一个正则表达式对象
    NSRegularExpression *repression = [NSRegularExpression regularExpressionWithPattern:regExStr options:0 error:&error];
    
    //查找符合条件的结果
    NSTextCheckingResult *result = [repression firstMatchInString:html options:0 range:NSMakeRange(0, html.length)];//在html中查询，范围是整个html的长度
    if (result) {
        NSRange range = result.range;
        NSString *source= [html substringWithRange:NSMakeRange(range.location + 1, range.length -2)];//range包含了><，所以location要+1，length要-2
        return source;
    }
    return nil;
}

-(NSString *)timeAgo{
    //比较时间差
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.created_at];
    if (interval < 60) {
        return @"刚刚";
    }else if (interval < 60 * 60){
        return [NSString stringWithFormat:@"%d 分钟前",(int)interval/60];
    }else if (interval < 60*60*24){
        return [NSString stringWithFormat:@"%d 小时前", (int)interval/(60 *60)];
    }else if (interval < 60 * 60 * 24 *30){
        return [NSString stringWithFormat:@"%d 天前", (int)interval/(60 *60 *24)];
    }else{
        return [NSDateFormatter localizedStringFromDate:self.created_at dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    }
    
}

@end
