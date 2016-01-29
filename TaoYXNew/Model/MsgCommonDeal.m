//
//  MsgCommonDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MsgCommonDeal.h"

@implementation MsgCommonDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *dictArray = [dict objectForKey:@"data"];
    
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        MsgCommonDeal *md = [[MsgCommonDeal alloc]init];
        md.title=[dictArray objectForKey:@"noticeTitle"];
        md.supplyDesc=[dictArray objectForKey:@"noticeDesc"];
        if(![[dictArray objectForKey:@"createTime"] isEqual:[NSNull null]])
        md.send_time=[self stdTimeToStr:[[dictArray objectForKey:@"createTime"]stringValue]];
        [arr addObject:md];
    }
    return arr;
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [objDateformat stringFromDate: date];
}
@end
